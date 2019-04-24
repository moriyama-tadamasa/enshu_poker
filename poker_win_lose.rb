
require "dbi"
$dbh = DBI.connect('DBI:SQLite3:./porker.db')
=begin
$dbh.do("DROP TABLE IF EXISTS score_tbl")
$dbh.do(
    "CREATE TABLE score_tbl(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        win INTEGER,
        lose INTEGER,
        draw INTEGER,
        hand CHAR(20))")
=end
def win_lose(ary_user,ary_com,hand_score_user,hand_score_com)
    ary_user_suit = []
    ary_user_num = []
    ary_com_num = []
    0.upto(4){|i|
        ary_user_suit << ary_user[i][0]
        ary_user_num << ary_user[i][1]
        ary_com_num << ary_com[i][1]
    }
    if hand_score_user > hand_score_com then
        puts "あなたの勝ちです"
        ary_user_txt = []
        0.upto(4){|i|
            ary_user_txt[i] = "#{ary_user_suit[i]}#{ary_user_num[i]}"
        }
        win_txt = ary_user_txt.join("|")
        
        $dbh.select_all("SELECT MAX(win) AS w FROM score_tbl") do |win|
            $win_num = win[:w].to_i
            if $win_num.nil? then
                $win_num = 1
            else
                $win_num += 1
            end
        end
        $dbh.do("INSERT INTO score_tbl(win,hand) VALUES(?,?)",$win_num,win_txt)
    end
    if hand_score_user < hand_score_com then
        puts "あなたの負けです"
        $dbh.do("INSERT INTO score_tbl(lose) VALUES(?)",1)
    end
    hi_card_user = []
    hi_card_user = ary_user_num.sort
    hi_card_com = []
    hi_card_com = ary_com_num.sort

    0.upto(3){|i|
        if hi_card_user[i] == 1 then
            hi_card_user[i] = 14
        end
        if hi_card_com[i] == 1 then
            hi_card_com[i] = 14
        end
    }

    if hand_score_user == 9 or hand_score_com == 5 then
        if ary_user_num[1] == 2
            hi_card_user[0] = 1
        end
        if ary_com_num[1] == 2
            hi_card_com[0] = 1
        end
    end
    hi_card_com = hi_card_com.sort
    hi_card_user = hi_card_user.sort
    draw_point = 0
    if hand_score_user == hand_score_com then
        4.downto(0){|i|
            if hi_card_user[i] > hi_card_com[i]
                puts "あなたの勝ちです"
                ary_user_txt = []
                0.upto(4){|i|
                    ary_user_txt[i] = "#{ary_user_suit[i]}#{ary_user_num[i]}"
                }
                win_txt = ary_user_txt.join("|")

                $dbh.select_all("SELECT MAX(win) AS w FROM score_tbl") do |win|
                    $win_num = win[:w].to_i
                    if $win_num.nil? then
                        $win_num = 1
                    else
                        $win_num += 1
                    end
                end
                $dbh.do("INSERT INTO score_tbl(win,hand) VALUES(?,?)",$win_num,win_txt)
                break
            elsif hi_card_user[i] < hi_card_com[i]
                puts "あなたの負けです"
                $dbh.do("INSERT INTO score_tbl(lose) VALUES(?)",1)
                break
            else
                draw_point += 1
            end
        }
    end
    if draw_point == 5 then
        puts "引き分けです"
        $dbh.do("INSERT INTO score_tbl(draw) VALUES(?)",1)
    end
end

#=begin
ary_user = []
ary_com = []
ary_user = [["D", 2],["S", 2],["C", 2],["D", 2],["H", 7]]
ary_com = [["C",2],["S",2],["H",2],["C",2],["D",6]]
win_lose(ary_user,ary_com,2,5)
#=end