def ch_card(t_ch,tn,tnn)
    if t_ch == 1
        tn = tnn
    end
end
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

        p "1.ゲームの開始"
        p "2.成績画面"
        p "0.終了"

        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        sel = gets.to_i
    case sel
        when 1 then
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
                                puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                puts "どのカードを交換しますか？"
                                puts "1:#{t1}を交換する"
                                puts "2:#{t2}を交換する"
                                puts "3:#{t3}を交換する"
                                puts "4:#{t4}を交換する"
                                puts "5:#{t5}を交換する"
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
                                if t2_ch == 2
                                    t2 = t7
                                end
                                if t3_ch == 3
                                    t3 = t8
                                end
                                if t4_ch == 4
                                    t4 = t9
                                end
                                if t5_ch == 1
                                    t5 = t10
                                end
                                        puts "~~~~~~~~~~~~勝敗画面~~~~~~~~~~~~"
                                        card = 0
                                        if (t1 == "[s1]" && t5 == "[c1]")
                                            p "あなたの役はワンペアです"
                                            card = 1
                                        else
                                            p "あなたの役はノーペアです"
                                        end
                                        puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                        p "COMの手札はノーペアです"
                                        puts "[[s10]|[c8]|[h12]|[d13]|[h1]]"
                                        if card == 1
                                            p "あなたの勝ちです"
                                            win += 1
                                            p "戦績:#{win}勝#{lose}敗"
                                            ary_win_card << "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                            p ary_win_card
                                        else
                                            p "あなたの負けです"
                                            lose += 1
                                            p "戦績:#{win}勝#{lose}敗"
                                        end
                                        
                                        t1_ch = 0
                                        t2_ch = 0
                                        t3_ch = 0
                                        t4_ch = 0
                                        t5_ch = 0
                                
                                        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                                        p "続けますか? 0でメインメニュー、0以外で続けます"
                                        tuduki = gets.to_i

                            if tuduki == 0 then                    
                                break
                            end
                        
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