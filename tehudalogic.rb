=begin
５３枚の山札混ぜて５枚ずつ引くやつ
=end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')


class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS deck")
        $dbh.do("CREATE TABLE deck(id integer primary key,suit char(20),number integer)")
        #トランプ全部つっこむとこ
        1.upto(13){|i|
        $dbh.do("insert into deck(suit,number) VALUES(?,?)","D",i)
        $dbh.do("insert into deck(suit,number) VALUES(?,?)","H",i)
        $dbh.do("insert into deck(suit,number) VALUES(?,?)","S",i)
        $dbh.do("insert into deck(suit,number) VALUES(?,?)","C",i)
        }
        $dbh.select_all("select number,suit from deck"){|crd|
            deck << [crd[1],crd[0]]
        }
        return deck
    end

    def fulldraw(name)
        fb = []
        $dbh.do("DROP TABLE IF EXISTS #{name}")
        $dbh.do("CREATE TABLE #{name}(id integer primary key,suit char(20),number integer)")
        #トランプ抜くとこ
        5.times{|j|
            while(1)
                dc = 0
                r = rand(52)
                $dbh.select_all("select suit,number from deck where id = ?",r){|crd|
                    dc = crd[0],crd[1]
                }
                if dc != nil && dc != 0 && dc !=[]
                    $dbh.do("insert into #{name}(suit,number) values(?,?)",dc[0],dc[1])
                    break
                end
            end
            fb << dc
            $dbh.do("delete from deck where id = ?",r)
        }
        return fb
    end

    def draw()
        sb = 0
        #トランプ抜くとこ
        while(1)
            sc = 0
            r = rand(52)
            $dbh.select_all("select suit,number from deck where id = #{r}"){|crd|
                sc = crd[0],crd[1]
            }
            if sc != nil && sc != 0 && sc !=[]
                $dbh.do("delete from deck where id = ?",r)
                break
            end
        end
        #puts "ドローしました"
        sb = sc
        return sb
    end

    def pdraw(cid)
        #プレイヤー専用のやーつ
        sb = 0
        while(1)
            sc = 0
            r = rand(52)
            $dbh.select_all("select suit,number from deck where id = #{r}"){|crd|
                sc = crd[0],crd[1]
            }
            if sc != nil && sc != 0 && sc !=[]
                break
            end
        end
        $dbh.do("update playercard set suit=?,number=? where id=#{cid}",sc[0],sc[1])
        sb = sc
        return sb
    end



=begin
    def npcchoice(drw)
        pdw = 0
        tdp = 0
        t=[]
        p drw
        $dbh.select_all("select count(number) from ncard group by number having 1<count(*)"){|npcard|
        #重複している数
            pdw = npcard[0].to_i
        }
        p pdw
        if pdw > 3
            p drw
        else
            if pdw > 1
                $dbh.select_all("select number from ncard group by number having 1<count(number)"){|lll|
                    #重複してるカードの等級
                    tdp = lll[0].to_i
                }
                p drw
                p tdp
                #機能し始めた
                drw.each{|l|
                    if l[1] != tdp
                        l = draw()
                    else
                        l = l
                    end
                    t << l
                }
            else
                #機能しなくなった
                t = fulldraw("ncard")
            end
        end 
        return t
    end
=end
    def comchoice(drw)
        pdw = 0
        tdp = 0
        #p drw
        $dbh.select_all("select count(number) from comcard group by number having 1<count(*)"){|npcard|
        #重複している数
            pdw = npcard[0].to_i
            #print "pdwの値"
            #p pdw
        }
        if pdw == 0
            drw = fulldraw("comcard")
        else
            if pdw > 1
                if pdw == 4
                    return drw
                end
                pdw.times{|d|
                    $dbh.select_all("select number from comcard group by number having 1 < count(number)"){|lll|
                        #重複してるカードの等級
                        tdp = lll[0].to_i
                        #p tdp
                        #謎
                        drw.length.times{|l|
                            #puts ""
                            #puts "drw[#{l}][1]の値"
                            #p drw[l][1]
                            #puts "tdpの値"
                            #p tdp
                            if drw[l][1] != tdp
                                drw[l] = draw()
                            else
                                #p drw[l]
                            end
                            #$dbh.do("insert into ncard(number,suit) values(?,?)",t[0],t[1])
                            #puts "drw[#{l}]の値"
                            #p drw[l]
                            #puts ""
                        }
                        #print "t壊れる#{t}"
                        #s = gets
                    }
                }
            end
        end
        #p drw
        $dbh.do("DROP TABLE IF EXISTS comcard")
        $dbh.do("CREATE TABLE comcard(id integer primary key,suit char(20),number integer)")
        drw.each{|d|
        $dbh.do("insert into comcard(suit,number) values(?,?)",d[0],d[1])
        }
        return drw
    end

end



#以下確認用

pd = Pokerdraw.new()

=begin
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
=end

pd.hudajunbi()

test1 = []

test1 = pd.fulldraw("playercard")

test = []

test = pd.fulldraw("comcard")

puts "-----変換前-----"

print "test1#{test1}\n"

print "test#{test}"

puts"\n------------"

puts ""

sbwwww = gets

test1[0] = pd.pdraw(1)

test = pd.comchoice(test)




puts "-----変換後-----"

print "test1#{test1}\n"

print "test#{test}"
 
puts"\n------------"

