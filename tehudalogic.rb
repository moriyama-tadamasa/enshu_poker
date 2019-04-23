=begin
５３枚の山札混ぜて５枚ずつ引くやつ
=end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')


class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS card")
        $dbh.do("CREATE TABLE card(id integer primary key,suit char(20),number integer)") 
        #トランプ全部つっこむとこ
        1.upto(13){|i|
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"D")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"H")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"S")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"C")
        }
        $dbh.select_all("select number,suit from card"){|crd|
            deck << [crd[0],crd[1]]
        }
        return deck
    end

    def fulldraw(name)
        fb = []
        dc = []
        $dbh.do("DROP TABLE IF EXISTS #{name}")
        $dbh.do("CREATE TABLE #{name}(id integer primary key,suit char(20),number integer)") 
        #トランプ抜くとこ
        5.times{|j|
            while(1)
                r = rand(52)
                $dbh.select_all("select number,suit from card where id = ?",r){|crd|
                    dc = crd[0],crd[1]
                }
                if dc != nil
                    $dbh.do("insert into #{name}(number,suit) values(?,?)",dc[0],dc[1])
                    break
                end
            end
            fb << dc
            $dbh.do("delete from card where id = ?",r) 

        }
        return fb
    end

    def draw()
        sb = []
        sc = []
        #トランプ抜くとこ
        while(1)
            r = rand(52)
            $dbh.select_all("select number,suit from card where id = #{r}"){|crd|
                sc = crd[1],crd[0]
                p sc
            }
            if sc != nil || sc != 0
                break
            end
        end
        sb = sc
        $dbh.do("delete from card where id = ?",r)
        return sb
    end
    def npcchoice(drw)
        pdw = 0
        tdp = 0
        $dbh.select_all("select count(number),number from ncard group by number having 1<count(*)"){|npcard|
        #重複している数
                pdw = npcard[0].to_i
        }
        if pdw > 1
            if pdw == 4
                return drw
            end
            $dbh.select_all("select number from ncard group by number having 1<count(number)"){|lll|
                #重複してるカードの等級
                tdp = lll[0].to_i
            }
            5.times{|l|
                if drw[l] != tdp
                    drw[l] = draw()
                else
                    drw[l] = drw[l]
                end
            }
        else
            drw = fulldraw("ncard")
        end
    end 
end








#以下確認用

pd = Pokerdraw.new()

s = pd.hudajunbi()

p s

puts ""

s = pd.draw()

p s

puts ""

s =[pd.hudajunbi(),pd.fulldraw("ncard"),pd.fulldraw("mcard")]


p s

t = pd.draw()

$dbh.select_all("select suit,number from card"){|crd|
    print "#{crd[0]}#{crd[1]}\n"
}
puts ""
puts t[0]

trw = pd.draw()
tlw = pd.draw()

test = []
test = pd.fulldraw("ncard")
puts "jaberunulualalalalala"
p test
puts"bananaajilililili"
puts ""

pd.npcchoice(test)


puts "gaba"
p test
puts "GABA"


#p pdw
#if pdw ==4 
#    break
#    else
 #       if pdw <=2
  #          5.times{|i|
#
 #           p chanf
  #          }
#


#puts "kusozako"
#puts tdp
#puts "gabagaba"

#p pdw
#tcw = "trw[1]"+"tlw[1]"

#p tcw
