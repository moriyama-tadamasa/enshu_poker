=begin
５３枚の山札混ぜて５枚ずつ引くやつ
=end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')


class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS card")
        $dbh.do("CREATE TABLE card(id integer primary key,number integer,suit char(20))") 
        $dbh.do("DROP TABLE IF EXISTS mcard")
        $dbh.do("CREATE TABLE mcard(id integer primary key,mcard )") 
        $dbh.do("DROP TABLE IF EXISTS ncard")
        $dbh.do("CREATE TABLE ncard(id integer primary key,ncard )") 
        #トランプ全部つっこむとこ
        1.upto(13){|i|
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"D")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"H")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"S")
        $dbh.do("insert into card(number,suit) VALUES(?,?)",i,"C")
        }
        $dbh.select_all("select number,suit from card"){|crd|
            deck << [crd[1],crd[0]]
        }
        return deck
    end

    def fulldraw()
        fb = []
        dc = []
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

$dbh.select_all("select suit,number from card"){|crd|
    print "#{crd[0]}#{crd[1]}\n"
}
puts ""
puts t[0]

trw = pd.draw()
tlw = pd.draw()

tcw = trw[1] + tlw[1]

p tcw

npc = pd.fulldraw()




