=begin
５３枚の山札混ぜて５枚ずつ引くやつ
=end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')


class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS card")
        $dbh.do("CREATE TABLE card(id integer primary key,number intger,suit char(20))")
        #トランプ全部つっこむとこ
        1.upto(13){|i|
        $dbh.do("insert into card(suit,number) VALUES(?,?)","D",i)
        $dbh.do("insert into card(suit,number) VALUES(?,?)","H",i)
        $dbh.do("insert into card(suit,number) VALUES(?,?)","S",i)
        $dbh.do("insert into card(suit,number) VALUES(?,?)","C",i)
        }
        $dbh.select_all("select number,suit from card"){|crd|
            deck << [crd[1],crd[0]]
        }
        return deck
    end

    def fulldraw()
        fb = []
        dc = ""
        #トランプ抜くとこ
        5.times{|j|
            while(1)
                r = rand(52)
                $dbh.select_all("select number,suit from card where id = ?",r){|crd|
                    dc = crd[1],crd[0]
                }
                if dc != nil
                    break
                end
            end
            fb << dc
            $dbh.do("delete from card where id = ?",r)
        }
        return fb
    end

    def draw()
        sb = ""
        sc = ""
        #トランプ抜くとこ
        while(1)
            r = rand(52)
            $dbh.select_all("select number,suit from card where id = #{r}"){|crd|
                sc = crd[1]+crd[0]
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
                if drw[0] != tdp
                    drw[0] = draw()
                    p drw[0]
                else

                    p drw[l]
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

s =[pd.hudajunbi(),pd.fulldraw(),pd.fulldraw()]

p s

t = pd.draw()

$dbh.select_all("select card from card"){|crd|
    puts crd[0]
}
puts ""
puts t[0]

trw = pd.draw()
tlw = pd.draw()

test = []
test = pd.fulldraw("ncard")
puts "jaberunulualalalalala"
print test
puts"bananaajilililili"
puts ""

pd.npcchoice(test)

 sbwwww = gets

puts "gaba"
p test
puts "GABA"

