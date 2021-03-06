require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'
require './lib/node'
require 'simplecov'
require 'pry'
SimpleCov.start


class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new
    assert_instance_of CompleteMe, complete_me
  end

  def test_simple_insert
    
    complete_me = CompleteMe.new

    complete_me.insert("pizza")
    assert_equal 1, complete_me.count
  end

  def test_it_has_empty_root
    complete_me = CompleteMe.new

    assert_nil complete_me.root.value
    assert_instance_of Node, complete_me.root
  end

  def test_selections_store_default_values
    complete_me = CompleteMe.new
    hash = {}

    assert_equal hash, complete_me.selections
  end

  def test_real_insert
    skip
  
    complete_me = CompleteMe.new
    complete_me.insert("pizza")
   
    leaf = complete_me.root.child("p").child("i").child("z").child("z").child("a")

    assert_instance_of Node, leaf
    
    assert leaf.complete_word?
    empty_children = {}

    assert_equal empty_children, leaf.children
  end

  def test_dictionary_count
   skip
    complete_me = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    complete_me.populate(dictionary)

    assert_equal 235886, complete_me.count
  end

  def test_single_suggest
    complete_me = CompleteMe.new
    complete_me.insert("pizza")

    assert_equal ["pizza"], complete_me.suggest("piz")
  end

  def test_suggest
    skip
    complete_me = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    complete_me.populate(dictionary)
    expected = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]

    assert_equal expected, complete_me.suggest("piz")
  end
  
  def test_it_can_select
    
    complete_me = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")    
    complete_me.populate(dictionary)
    complete_me.select("piz", "pizzeria")
    complete_me.select("piz", "pizzeria")
    complete_me.select("piz", "pizzeria")
    complete_me.select("pi", "pizza")
    complete_me.select("pi", "pizza")
    complete_me.select("pi", "pizzicato")
    #selection adds to weight somehow then sorts the suggested array

    expected = ["pizzeria", "pize", "pizza", "pizzicato", "pizzle"]
    assert_equal expected, complete_me.suggest("piz")
  end

end

 