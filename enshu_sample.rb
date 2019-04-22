t1_ch = 0
t2_ch = 0
t3_ch = 0
t4_ch = 0
t5_ch = 0
win = 0
lose = 0
ary_win_card = []
while(1)
    while(1)
        puts "~~~~~~~~~~~~メイン画面~~~~~~~~~~~~"
        puts "0:ゲームの開始"
        puts "1:成績画面"
        puts "2:終了"
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        sel = gets.to_i
    case sel
        when 0 then
            while(1)
                t1 = "[s1]"
                t1_disp = t1
                t2 = "[c2]"
                t2_disp = t2
                t3 = "[h3]"
                t3_disp = t3
                t4 = "[d5]"
                t4_disp = t4
                t5 = "[s6]"
                t5_disp = t5
                t6 = "[c7]"
                t7 = "[h9]"
                t8 = "[d10]"
                t9 = "[s11]"
                t10 = "[c1]"

                puts "~~~~~~~~~~~~ゲーム画面~~~~~~~~~~~~"
                puts "現在の手札"
                puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                puts "手札の交換：0"
                puts "メイン画面に戻る：1"
                puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                ans_game_menu = gets.to_i
                ans_game_trade = 99
                    case ans_game_menu
                        when 0 then
                            while(ans_game_trade != 0)
                                puts "~~~~~~~~~~~手札交換画面~~~~~~~~~~~"
                                puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                puts "交換したいカードを選択してください"
                                puts "選択され●がついたカードが交換されます"
                                print "1:#{t1}  "
                                print "2:#{t2}  "
                                puts "3:#{t3}"
                                print "4:#{t4}  "
                                puts "5:#{t5}"
                                puts "0:カードの交換を実行する"
                                puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                                ans_game_trade = gets.to_i
                                case ans_game_trade
                                    when 0 then
                                            ans_game_trade_end = 10
                                            while(1)
                                                puts "~~~~~~~~~~~~交換終了確認画面~~~~~~"
                                                puts "本当に交換してよろしいですか？"
                                                puts "1:実行"
                                                puts "0:交換を継続"
                                                ans_game_trade_end = gets.to_i
                                                
                                                if ans_game_trade_end == 1
                                                    ans_game_trade = 0
                                                    break
                                                elsif ans_game_trade_end == 0
                                                    ans_game_trade = 10
                                                    break
                                                else 
                                                    puts "0か1で入力してください"
                                                end
                                            end
                                    when 1 then
                                        if t1_ch == 0 then
                                            t1_ch = 1
                                            t1 = t1 + "●"
                                        else
                                            t1_ch = 0
                                            t1 = t1_disp
                                        end
                                    when 2 then
                                        if t2_ch == 0 then
                                            t2_ch = 1
                                            t2 = t2 + "●"
                                        else
                                            t2_ch = 0
                                            t2 = t2_disp
                                        end
                                    when 3 then
                                        if t3_ch == 0 then
                                            t3_ch = 1
                                            t3 = t3 + "●"
                                        else
                                            t3_ch = 0
                                            t3 = t3_disp
                                        end
                                    when 4 then
                                        if t4_ch == 0 then
                                            t4_ch = 1
                                            t4 = t4 + "●"
                                        else
                                            t4_ch = 0
                                            t4 = t4_disp
                                        end
                                    when 5 then
                                        if t5_ch == 0 then
                                            t5_ch = 1
                                            t5 = t5 + "●"
                                        else
                                            t5_ch = 0
                                            t5 = t5_disp
                                        end
                                    else
                                end
                            end
                                if t1_ch == 1
                                    t1 = t6
                                end
                                if t2_ch == 1
                                    t2 = t7
                                end
                                if t3_ch == 1
                                    t3 = t8
                                end
                                if t4_ch == 1
                                    t4 = t9
                                end
                                if t5_ch == 1
                                    t5 = t10
                                end
                                puts "~~~~~~~~~~~~勝敗画面~~~~~~~~~~~~~~"
                                        card = 0
                                        if (t1 == "[s1]" && t5 == "[c1]")
                                            puts "あなたの役はワンペアです"
                                            card = 1
                                        else
                                            puts "あなたの役はノーペアです"
                                        end
                                        puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                        puts "COMの手札はノーペアです"
                                        puts "|s10|c8|h12|d13|h1|"
                                        if card == 1
                                            puts "あなたの勝ちです"
                                            win += 1
                                            puts "戦績:#{win}勝#{lose}敗"
                                            ary_win_card << "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                        else
                                            puts "あなたの負けです"
                                            lose += 1
                                            puts "戦績:#{win}勝#{lose}敗"
                                        end
                                        
                                        t1_ch = 0
                                        t2_ch = 0
                                        t3_ch = 0
                                        t4_ch = 0
                                        t5_ch = 0
                                        tuduki = 10
                                        while(tuduki != 0 && tuduki != 1)
                                            puts "~~~~~~~~~~~~続行画面~~~~~~~~~~~~~~"
                                            puts "続けますか?"
                                            puts "0:続行"
                                            puts "1:メインメニューへ"
                                            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                                            tuduki = gets.to_i
                                            if tuduki != 0 && tuduki != 1
                                                puts "0か1で入力してください"
                                            end
                                        end

                            if tuduki == 1 then                    
                                break
                            end
                        when 1 then
                            break
                end
        end

        when 1 then
            total = win + lose
            i = 1
            score_menu = 999
            while score_menu != 0
                i = 1
                puts "~~~~~~~~~~~~成績画面~~~~~~~~~~~~~~"
                if(total == 0)
                    puts "成績がありません"
                else
                    puts "#{total}戦#{win}勝#{lose}敗"
                    1.upto(win){|x|
                    puts "#{i}勝目"
                    if win > 0
                        puts ary_win_card[i-1]
                    end
                    if win > i then
                        i += i
                    end
                }
            end
            puts "成績の初期化：１"
            puts "メイン画面へ戻る：0"
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            score_menu = gets.to_i
            case score_menu
                when 1 then
                    score_menu_start = 10
                    while(score_menu_start != 0 && score_menu_start != 1)
                        puts "~~~~~~~~~成績初期化確認画面~~~~~~~"
                        puts "本当に初期化してよろしいですか？"
                        puts "0:初期化をキャンセル"
                        puts "1:初期化を実行"
                        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                        score_menu_start = gets.to_i
                            if score_menu_start == 1
                                win = 0
                                lose = 0
                                total = 0
                                ary_win_card.clear
                                i=1
                            elsif score_menu_start !=0
                                puts "1か0で入力してください"
                            end
                    end
            end
        end
            
        when 2 then
            while(1) do
                puts "~~~~~~~~~ゲーム終了確認画面~~~~~~~"
                puts "本当に終了しますか？"
                puts "0:メイン画面へ戻る"
                puts "1:終了する"
                puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                ans_end = gets.to_i
                case ans_end
                    when 0 then
                        break
                    when 1 then
                        exit
                    else
                        puts "0か1で入力してください"
                end
            end
        else
            puts "0~2の数字で入力してください"
    end

end
end