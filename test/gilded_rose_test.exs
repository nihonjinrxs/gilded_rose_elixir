defmodule GildedRoseTest do
  use ExUnit.Case

  import GildedRose, only: [update_item: 1]

  describe "Some item" do
    @some_item %Item{ name: "Super duper", quality: 5, sell_in: 5 }

    test "it has a name" do
      assert Map.has_key?(@some_item, :name)
    end

    test "it has a sell_in value" do
      assert Map.has_key?(@some_item, :sell_in)
    end

    test "it has a quality value" do
      assert Map.has_key?(@some_item, :quality)
    end

    # This is a candidate for property-based testing
    test "it has quality >= 0" do
      assert @some_item.quality >= 0
    end

    # This is a candidate for property-based testing
    test "it has quality <= 50" do
      assert @some_item.quality <= 50
    end

    test "when sell_in negative, quality decreases by 2" do
      q = @some_item.quality
      item = %Item{ @some_item | sell_in: -1 }
      expected = %Item{ @some_item | sell_in: item.sell_in - 1,
                                     quality: q - 2 }
      assert update_item(item) == expected
    end

    test "when sell_in negative, quality == 1, quality becomes 0" do
      item = %Item{ @some_item | sell_in: -1, quality: 1 }
      expected = %Item{ @some_item | sell_in: item.sell_in - 1,
                                     quality: 0 }
      assert update_item(item) == expected
    end

    test "when quality is 0, quality doesn't decrease anymore" do
      item = %Item{ @some_item | quality: 0 }
      expected = item
      assert update_item(item) == expected
    end

    test "when sell_in and quality > 0, quality decreases by 1 " do
      item = @some_item
      expected = %Item{ item | sell_in: item.sell_in - 1,
                               quality: item.quality - 1 }
      assert update_item(item) == expected
    end
  end
end
