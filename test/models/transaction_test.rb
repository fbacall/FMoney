require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "bulk insert" do
    i1 = Transaction.create(date: '2009-10-01', balance: '100.00', value: '100.00', description: 'Initial')
    i2 = Transaction.create(date: '2009-10-03', balance: '110.00', value: '10.00', description: 'Earned money')
    i3 = Transaction.create(date: '2009-10-04', balance: '100.00', value: '-10.00', description: 'Spent money')

    t1 = Transaction.new(date: '2009-10-02', balance: '98.00', value: '-2.00', description: 'McDonalds')
    t2 = Transaction.new(date: '2009-10-01', balance: '100.00', value: '100.00', description: 'Initial')
    t3 = Transaction.new(date: '2009-10-03', balance: '100.00', value: '2.00', description: 'McDonalds refund')

    assert_difference('Transaction.count', 2) do
      Transaction.bulk_insert([t1, t2, t3])
    end

    assert t1.persisted?
    refute t2.persisted?
    assert t3.persisted?

    assert_equal 1, i1.reload.position
    assert_equal 2, t1.reload.position
    assert_equal 3, t3.reload.position
    assert_equal 4, i2.reload.position
    assert_equal 5, i3.reload.position
  end

  test 'fixes dates' do
    t1 = Transaction.new(date: '12-aug-99', balance: '100.00', value: '2.00', description: 'McDonalds refund')
    t1.valid?
    assert_equal 1999, t1.date.year

    t2 = Transaction.new(date: '12-aug-21', balance: '100.00', value: '2.00', description: 'McDonalds refund')
    t2.valid?
    assert_equal 2021, t2.date.year

    t3 = Transaction.new(date: '12-aug-1980', balance: '100.00', value: '2.00', description: 'McDonalds refund')
    t3.valid?
    assert_equal 1980, t3.date.year
  end
end
