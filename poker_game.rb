require "dbi"
require "./poker_hand"
require "./poker_win_lose"
require "./tehudalogic"
$dbh = DBI.connect('DBI:SQLite3:./porker.db')
t1_ch = 0
t2_ch = 0
t3_ch = 0
t4_ch = 0
t5_ch = 0
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
                    puts "~~~~~~~~~~~~ゲーム画面~~~~~~~~~~~~"
                    puts "現在の手札"
                    puts "[||||]"
                    puts "手札の交換：0"
                    puts "メイン画面に戻る：1"
                    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    ans_game_menu = gets.to_i
                    ans_game_trade = 99
                    case ans_game_menu
                        when 0 then
                            while(ans_game_trade != 0)
                                puts "~~~~~~~~~~~手札交換画面~~~~~~~~~~~"
                                #↓現在の手札を表示
                                puts "[||||]"
                                puts "交換したいカードを選択してください"
                                puts "選択され●がついたカードが交換されます"
                                print "1:t1  "
                                print "2:t2  "
                                puts "3:t3"
                                print "4:t4  "
                                puts "5:t5"
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
                            puts "~~~~~~~~~~~~勝敗画面~~~~~~~~~~~~~~"
                            puts "あなたの手札は〜〜です"
                            puts "[t1|t2|t3|t4|t5]"
                            puts "COMの手札は〜〜です"
                            puts "|t1|t2|t3|t4|t5|"
                            puts "あなたの勝ちです"
                            puts "戦績:win勝lose敗draw分"  
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
                        else
                    end
                end
            when 1 then
                score_menu = 999
                while score_menu != 0
                    puts "~~~~~~~~~~~~成績画面~~~~~~~~~~~~~~"
                    total = 0
                    win = 0
                    lose = 0
                    draw = 0
                    ary_wins_card = []
                    $dbh.select_all('SELECT MAX(id) ,MAX(win) ,SUM(lose) ,SUM(draw) FROM score_tbl') do |row|
                        total = row[0].to_i
                        win = row[1].to_i
                        lose = row[2].to_i
                        draw = row[3].to_i
                    end
                    if(total == 0)
                        puts "成績がありません"
                    else
                        puts "#{total}戦#{win}勝#{lose}敗#{draw}分"
                    end
                #~~~~~~~~~~~~~~~~~~~~~~~~勝利手札表示~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    win_card_disp = []
                    hand = []
                    $dbh.select_all('SELECT win,hand,id FROM score_tbl WHERE win IS NOT NULL ORDER BY win DESC LIMIT 5') do |row2|
                        win_card_disp << row2[:win]
                        hand << row2[:hand]
                    end
                    0.upto(4){|i|
                        puts "#{win_card_disp[i]}勝目 : #{hand[i]}"
                    }
                #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    puts "成績の初期化：1"
                    puts "メイン画面へ戻る：0"
                    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    score_menu = gets.to_i
                    case score_menu
                        when 0 then
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
                                    $dbh.do("DROP TABLE IF EXISTS score_tbl")
                                    $dbh.do(
                                        "CREATE TABLE score_tbl(
                                            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                                            win INTEGER,
                                            lose INTEGER,
                                            draw INTEGER,
                                            hand CHAR(20)
                                        )"
                                    )
                                elsif score_menu_start != 0
                                    puts "0か1で入力してください"
                                end
                            end
                        #成績初期化確認画面のwhileループend
                        else
                            puts "0か1で入力してください"
                    end
                #成績画面からの遷移case文end  
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