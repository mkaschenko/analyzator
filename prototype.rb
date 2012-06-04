require 'test/unit'

class TestAnalyzator < Test::Unit::TestCase
  def setup
    @analyzator = Analyzator.new
  end

  attr_reader :analyzator

  def test_catch
    events = []
    assert_equal false, analyzator.catch(events)

    events = [2, 4, 5, 5, 2, 2, 4]
    assert_equal false, analyzator.catch(events)

    events = [1, 2, 3, 4, 5, 6, 7, 7, 7, 8]
    assert_equal true, analyzator.catch(events)
  end

  def test_information
    events = [0.1, 0.2, 0.3, 0.4, 0.5]
    assert_equal 2.3464393446710154, analyzator.information(events)
  end
end

class Analyzator

  # event happens 3 times in succession
  def catch(events)
    sequence = false

    while events.size.nonzero?
      first = events.shift
      break if sequence = first == events[0] && first == events[1]
    end

    sequence
  end

  # Claude Shannon's information
  # http://cl.ly/47071J39440r0k0W2w3N
  def information(events)
    - events.inject(0) { |sum, probability| sum + probability * Math.log2(probability) }
  end
end


events = Array.new(10) { (rand * 5 + 5) / 10 }
p events
p Analyzator.new.information events

# TODO: генетика, импринтирование, кондиционирование, обучение для 'существа'
# реакция на похожие события, на одинаковые