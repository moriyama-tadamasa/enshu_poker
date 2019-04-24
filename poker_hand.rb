def yaku_hantei(ary)
    #"以下ロイヤルストレートフラッシュ判定開始"
    ary_suit = []
    ary_num = []
    0.upto(4){|i|
       ary_suit << ary[i][0]
       ary_num << ary[i][1]
    }
    suit = ary_suit[0]
    suit_count = 1
    0.upto(3){|i|
        if suit == ary_suit[i+1] then
            suit_count += 1
        end
    }
    ary_num_sort = []
    ary_num_sort = ary_num.sort
    stra_count = 1
    if ary_num_sort[0] == 1 then
        if ary_num_sort[1] == 10 then
            royal_stra_count = 2
            1.upto(3){|i|
                if ary_num_sort[i+1] == ary_num_sort[i] + 1 then
                    royal_stra_count += 1
                end
            }
        end
    end
    if royal_stra_count == 5 && suit_count == 5 then
        #puts "ロイヤルストレートフラッシュ!"
        return 10
    end
    #puts "ロイヤルストレートフラッシュ判定失敗"
    #~~~~~~~~~~~~~~~以下ストレートフラッシュ判定~~~~~~~~~~~~~~~~~~
    #puts "以下ストレートフラッシュ判定開始"
    0.upto(3){|i|
        if ary_num_sort[i+1] == ary_num_sort[i] + 1 then
            stra_count += 1
        end
    }
    if stra_count == 5 && suit_count == 5 then
    #    puts "ストレートフラッシュ!"
        return 9
    end
    #puts "ストレートフラッシュ判定失敗"
    #~~~~~~~~~~~~~~~~以下フォーカード判定~~~~~~~~~~~~~~~~~~~~
    #puts "以下フォーカード判定開始"
    case
        when ary_num_sort[0] == ary_num_sort[1] then
            four_card_count = 2
            four_card = ary_num_sort[0]
            1.upto(2){|i|
                if four_card == ary_num_sort[i+1]
                    four_card_count += 1
                end
            }
        when ary_num_sort[1] == ary_num_sort[2] then
            four_card_count = 2
            four_card = ary_num_sort[1]
            2.upto(3){|i|
                if four_card == ary_num_sort[i+1]
                    four_card_count += 1
                end
            }
        else
    end
    if four_card_count == 4 then
    #    puts "フォーカード!"
        return 8
    end
    #puts "フォーカード判定失敗"
    #~~~~~~~~~~~~~~~~~~~以下フルハウス判定~~~~~~~~~~~~~~~~~~~
    #puts "以下フルハウス判定開始"
    three_card = ary_num_sort[2]
    three_card_count = 0
    0.upto(4){|i|
        if three_card == ary_num_sort[i]
            three_card_count += 1
        end
    }
    ary_full = []
    if three_card_count == 3 then
        0.upto(4){|i|
            if ary_num_sort[i] != three_card
                ary_full << ary_num_sort[i]
            end
        }
        if ary_full[0] == ary_full[1] then
    #        puts "フルハウス!"
            return 7
        end
    end
    #puts "フルハウス判定失敗"
    #~~~~~~~~~~~~~~~~~~~以下フラッシュ判定~~~~~~~~~~~~~~~~~~~
    #puts "以下フラッシュ判定開始"
    if suit_count == 5 then
    #    puts "フラッシュ!"
        return 6
    end
    #puts "フラッシュ判定失敗"
    #~~~~~~~~~~~~~~~~~~~~以下ストレート判定~~~~~~~~~~~~~~~~~~
    #puts "以下ストレート判定開始"
    if stra_count == 5 then
    #    puts "ストレート!"
        return 5
    end
    #puts "ストレート判定失敗"
    #~~~~~~~~~~~~~~~~~~~~以下スリーカード判定~~~~~~~~~~~~~~~~
    #puts "以下スリーカード判定開始"
    if three_card_count == 3 then
    #    puts "スリーカード!"
        return 4
    end
    #puts "スリーカード判定失敗"
    #~~~~~~~~~~~~~~~~~~~~~以下ツーペア判定~~~~~~~~~~~~~~~~~~~~~
    #puts "以下ツーペア判定開始"
    pair = 0
    0.upto(3){|i|
        if ary_num_sort[i] == ary_num_sort[i+1] then
            pair += 1
        end
    }
    if pair == 2 then
    #    puts "ツーペア!"
        return 3
    end
    #puts "ツーペア判定失敗"
    #~~~~~~~~~~~~~~~~~~~~~~以下ワンペア判定~~~~~~~~~~~~~~~~~
    #puts "以下ワンペア判定開始"
    if pair == 1 then
    #    puts "ワンペア!"
        return 2
    end
    #puts "ワンペア判定失敗"
    #~~~~~~~~~~~~~~~~~~~~~~以下ノーペア判定~~~~~~~~~~~~~~~~~
    #puts "以上の役に全て当てはまらないのでノーペア判定です"
    #puts "ノーペア"
    return 1
end

=begin
ary = []
ary = [["D", 1],["S", 4],["C", 8],["D", 3],["H", 5]]

p ary


yaku_hantei(ary)
=end
