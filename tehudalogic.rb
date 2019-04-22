=begin
５３枚の山札混ぜて５枚ずつ引くやつ
=end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')

s = []
t = []
class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS card")
        $dbh.do("CREATE TABLE card(id integer primary key,card char(20))") 
        $dbh.do("DROP TABLE IF EXISTS mcard")
        $dbh.do("CREATE TABLE mcard(id integer primary key,mcard )") 
        $dbh.do("DROP TABLE IF EXISTS ncard")
        $dbh.do("CREATE TABLE ncard(id integer primary key,ncard )") 
        #トランプ全部つっこむとこ
        1.upto(13){|i|
        $dbh.do("insert into card(card) VALUES(?)","D#{i}")
        $dbh.do("insert into card(card) VALUES(?)","H#{i}")
        $dbh.do("insert into card(card) VALUES(?)","S#{i}")
        $dbh.do("insert into card(card) VALUES(?)","C#{i}")
        }
        $dbh.select_all("select card from card"){|crd|
            deck += [crd[0]]
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
                $dbh.select_all("select card from card where id = #{r}"){|crd|
                    dc = [crd[0]]
                }
                if dc != nil
                    break
                end
            end
            fb += dc
            $dbh.do("delete from card where id = ?",r)
        }
        return fb
    end

    def draw()
        sb = []
        sc = ""
        #トランプ抜くとこ
        while(1)
            r = rand(52)
            $dbh.select_all("select card from card where id = #{r}"){|crd|
                sc = [crd[0]]
            }
            if sc != nil
                break
            end
        end
        sb += sc
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

$dbh.select_all("select card from card"){|crd|
    puts crd[0]
}
puts ""
puts t[0]