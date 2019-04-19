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
                t2 = "[c2]"
                t3 = "[h3]"
                t4 = "[d5]"
                t5 = "[s6]"
                t6 = "[c7]"
                t7 = "[h9]"
                t8 = "[d10]"
                t9 = "[s11]"
                t10 = "[c1]"

                puts "~~~~~~~~~~~~ゲーム画面~~~~~~~~~~~~"
                puts "現在の手札"
                puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                puts "手札の交換：1"
                puts "メイン画面に戻る：2"
                puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                ans_game_menu = gets.to_i
                ans_game_trade = 0
                    case ans_game_menu
                        when 1 then
                            while(ans_game_trade != 6)
                                puts "現在の手札"
                                puts "[#{t1}|#{t2}|#{t3}|#{t4}|#{t5}]"
                                puts "何枚目のカードを交換しますか？"
                                puts "1:左から1枚目のカードを交換する"
                                puts "2:左から2枚目のカードを交換する"
                                puts "3:左から3枚目のカードを交換する"
                                puts "4:左から4枚目のカードを交換する"
                                puts "5:左から5枚目のカードを交換する"
                                puts "6:カードの交換を終了する"
                                ans_game_trade = gets.to_i
                                case ans_game_trade
                                    when 1 then
                                        t1 = t6
                                    when 2 then
                                        t2 = t7
                                    when 3 then
                                        t3 = t8
                                    when 4 then
                                        t4 = t9
                                    when 5 then
                                        t5 = t10
                                    when 6 then
                                        puts "本当によろしいですか？ y/n"
                                        ans_game_trade_end = gets.to_s.chomp
                                        if ans_game_trade_end == "n"
                                            ans_game_trade = 0
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
                                        puts "[[s10]|[c8]|[h12]|[d13]|[h1]"
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
                                        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                                        p "続けますか? 1でメインメニュー、1以外で続けます"
                                        tuduki = gets.to_i
                                    else 
                                end
                            end
                            if tuduki == 1 then                    
                                break
                            end
                        when 2 then
                            break
                        else
                end
        end

        when 2 then
            total = win + lose
            i = 1
            score_menu = 0
            while score_menu != 2
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
            p "メイン画面へ戻る：2"
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            score_menu = gets.to_i
            case score_menu
                when 1 then
                    p "本当に初期化してよろしいですか？ y/n"
                    score_menu_start = gets.to_s.chomp
                        if score_menu_start == "y"
                            win = 0
                            lose = 0
                            total = 0
                            ary_win_card.clear
                        end
            end
        end
            
        when 0 then
            while(1) do
                puts "本当に終了しますか？ yで終了、nでメイン画面へ戻ります"
                ans_end = gets.to_s
                case ans_end.chomp
                    when "y" then
                        exit
                    when "n" then
                        break
                    else
                        p "yかnで入力してください"
                end
            end
        else
            p "0~2の数字で入力してください"
    end

end
end