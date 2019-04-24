require "dbi"
$dbh = DBI.connect('DBI:SQLite3:./porker.db')



#when 1 then

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
    0.upto(win-1){|i|
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
                elsif score_menu_start !=0
                    puts "1か0で入力してください"
                end
            end
            #成績初期化確認画面のwhileループend
        else
            puts "1か0で入力してください"
    end
    #成績画面からの遷移case文end
end
#成績画面用のwhileループend