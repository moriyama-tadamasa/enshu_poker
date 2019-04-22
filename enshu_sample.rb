def ch_card(t_ch,tn,tnn)
    if t_ch == 1
        tn = tnn
    end
end

require "dbi"

$dbh = DBI.connect('DBI:SQLite3:porker.db')


class Pokerdraw
    def hudajunbi()
        deck = []
        $dbh.do("DROP TABLE IF EXISTS card")
        $dbh.do("CREATE TABLE card(id integer primary key,number intger,suit char(20))") 
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
            deck += [crd[1]+crd[0]]
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
                $dbh.select_all("select number,suit from card where id = #{r}"){|crd|
                    dc = [crd[1]+crd[0]]
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
end

win = 0
lose = 0
mcard = []
ncard = []
ary_win_card = []
while(1)
    while(1)
        puts "~~~~~~~~~~~~メイン画面~~~~~~~~~~~~"

        p "1.ゲームの開始"
        p "2.成績画面"
        p "0.終了"

        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        sel = gets.to_i
    case sel
        when 1 then
            while(1)
                tch = Array.new(5,0)
                p tch
                tcha = ["","","","",""]
                dbc = Pokerdraw.new
                dbc.hudajunbi()
                mcard = dbc.fulldraw()
                ncard = dbc.fulldraw()
                puts "~~~~~~~~~~~~ゲーム画面~~~~~~~~~~~~"
                puts "現在の手札"
                puts "[[#{tcha[0]+mcard[0]}]|[#{tcha[1]+mcard[1]}]|[#{tcha[2]+mcard[2]}]|[#{tcha[3]+mcard[3]}]|[#{tcha[4]+mcard[4]}]]"
                puts "手札の交換：1"
                puts "メイン画面に戻る：0"
                puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                ans_game_menu = gets.to_i
                ans_game_trade = 99
                    case ans_game_menu
                        when 0 then
                            break
                        when 1 then
                            while(ans_game_trade != 0)
                                puts "現在の手札"
                                puts "[[#{tcha[0]+mcard[0]}]|[#{tcha[1]+mcard[1]}]|[#{tcha[2]+mcard[2]}]|[#{tcha[3]+mcard[3]}]|[#{tcha[4]+mcard[4]}]]"
                                puts "どのカードを交換しますか？"
                                puts "1:#{mcard[0]}を交換する"
                                puts "2:#{mcard[1]}を交換する"
                                puts "3:#{mcard[2]}を交換する"
                                puts "4:#{mcard[3]}を交換する"
                                puts "5:#{mcard[4]}を交換する"
                                puts "0:カードの交換を終了する"
                                ans_game_trade = gets.to_i
                            
                                case ans_game_trade
                                    when 0 then
                                        puts "本当によろしいですか？"
                                        puts "0でカードの交換を終了します。0以外で継続します"
                                        ans_game_trade_end = gets.to_i
                                        if ans_game_trade_end == 0 then
                                            ans_game_trade = 0
                                        else
                                            ans_game_trade = 10
                                        end
                                    when 1 then
                                        if tch[0] == 0 then
                                            tch[0] = 1
                                            tcha[0] =  "●"
                                        else
                                            tch[0] = 0
                                            tcha[0] = ""
                                        end
                                    when 2 then
                                        if tch[1] == 0 then
                                            tch[1] = 1
                                            tcha[1] =  "●"
                                        else
                                            tch[1] = 0
                                            tcha[1] = ""
                                        end
                                    when 3 then
                                        if tch[2] == 0 then
                                            tch[2] = 1
                                            tcha[2] =  "●"
                                        else
                                            tch[2] = 0
                                            tcha[2] = ""
                                        end
                                    when 4 then
                                        if tch[3] == 0 then
                                            tch[3] = 1
                                            tcha[3] =  "●"
                                        else
                                            tch[3] = 0
                                            tcha[3] = ""
                                        end
                                    when 5 then
                                        if tch[4] == 0 then
                                            tch[4] = 1
                                            tcha[4] =  "●"
                                        else
                                            tch[4] = 0
                                            tcha[4] = ""
                                        end
                                    else

                                    end
                                end
                            end

                            5.times{
                                if tch[0] == 1
                                    mcard[0] = dbc.draw()
                                    p mcard
                                    tch[0] = 0
                                end
                                if tch[1]  == 1
                                    mcard[1] = dbc.draw()
                                    tch[1] = 0
                                    p mcard
                                end
                                if tch[2] == 1
                                    mcard[2] = dbc.draw()
                                    tch[2] = 0
                                    p mcard
                                end
                                if tch[3] == 1
                                    mcard[3] = dbc.draw()
                                    tch[3] = 0
                                    p mcard
                                end
                                if tch[4] == 1
                                    mcard[4] = dbc.draw()
                                    p mcard
                                    tch[4] = 0
                                end

                                }
                                        puts "~~~~~~~~~~~~勝敗画面~~~~~~~~~~~~"
                                        card = 0
                                        if (mcard[0] == "[s1]" && mcard[4] == "[c1]")
                                            p "あなたの役はワンペアです"
                                            card = 1
                                        else
                                            p "あなたの役はノーペアです"
                                        end
                                        puts "[[#{mcard[0]}]|[#{mcard[1]}]|[#{mcard[2]}]|[#{mcard[3]}]|[#{mcard[4]}]]"
                                        p "COMの手札はノーペアです"
                                        puts "[[s10]|[c8]|[h12]|[d13]|[h1]]"
                                        if card == 1
                                            p "あなたの勝ちです"
                                            win += 1
                                            p "戦績:#{win}勝#{lose}敗"
                                            ary_win_card << "[[#{mcard[0]}]|[#{mcard[1]}]|[#{mcard[2]}]|[#{mcard[3]}]|[#{mcard[4]}]"
                                            p ary_win_card
                                        else
                                            p "あなたの負けです"
                                            lose += 1
                                            p "戦績:#{win}勝#{lose}敗"
                                        end
                                        
                                        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                                        p "続けますか? 0でメインメニュー、0以外で続けます"
                                        tuduki = gets.to_i

                            if tuduki == 0 then                    
                                break
                            end
                        
                end


        when 2 then
            total = win + lose
            i = 1
            score_menu = 999
            while score_menu != 0
                puts "~~~~~~~~~~~~成績画面~~~~~~~~~~~~"
                if(total == 0)
                    p "成績がありません"
                else
                    p "#{total}戦#{win}勝#{lose}敗"
                    1.upto(win){|x|
                    p "#{i}勝目"
                    if win > 0
                        p ary_win_card[i-1]
                    end
                    i += i
                }
            end
            p "成績の初期化：１"
            p "メイン画面へ戻る：0"
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            score_menu = gets.to_i
            case score_menu
                when 1 then
                    p "本当に初期化してよろしいですか？"
                    p "1で初期化を実行、それ以外で初期化をキャンセルします"
                    score_menu_start = gets.to_i
                        if score_menu_start == 1
                            win = 0
                            lose = 0
                            total = 0
                            ary_win_card.clear
                        end
            end
        end
            
        when 0 then
            while(1) do
                puts "本当に終了しますか？ 0で終了、1でメイン画面へ戻ります"
                ans_end = gets.to_i
                case ans_end
                    when 0 then
                        exit
                    when 1 then
                        break
                    else
                        p "0か1で入力してください"
                end
            end
        else
            p "0~2の数字で入力してください"
    end

end
end