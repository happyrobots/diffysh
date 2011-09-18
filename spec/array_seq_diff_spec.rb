require 'spec_helper'

describe Array do

  describe "#seq_diff" do
    describe "benchmark" do
      it "is correct and runs fast" do
        min, max = 1, 10000
        list1, list2 = [], []
        (min..max).to_a.each do |i|
          list1 << i if rand(7) >= 3
          list2 << i if rand(10) < 5
        end

        list_result = {}
        seq_diff_period = Benchmark.realtime { list_result = list1.seq_diff(list2) }
        correct_list_result = []
        diff_period = Benchmark.realtime { correct_list_result = list1.diff(list2) }
        correct_list_result.should == list_result

        puts "Seq Diff: #{seq_diff_period}, Diff: #{diff_period}, Delta: #{seq_diff_period - diff_period}"
        diff_period.should > seq_diff_period
      end
    end

    describe "adding" do
      context "one at the head" do
        it "works" do
          old = [2]
          current = [1,2]
          current.seq_diff(old).should == {:added => [1]}

          old = [2,3,4,5]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [1]}
        end
      end

      context "one at the tail" do
        it "works" do
          old = [4]
          current = [4,5]
          current.seq_diff(old).should == {:added => [5]}

          old = [1,2,3,4]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [5]}
        end
      end

      context "one in the middle" do
        it "works" do
          old = [2,4]
          current = [2,3,4]
          current.seq_diff(old).should == {:added => [3]}

          old = [2,4,5]
          current = [2,3,4,5]
          current.seq_diff(old).should == {:added => [3]}

          old = [1,2,4,5]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [3]}
        end
      end

      context "two or more" do
        it "works" do
          old = [1,4,5]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [2,3]}

          old = [2,3,4]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [1,5]}

          old = [2,4]
          current = [1,2,3,4,5]
          current.seq_diff(old).should == {:added => [1,3,5]}

          old = []
          current = [1,6,7]
          current.seq_diff(old).should == {:added => [1,6,7]}

          old = [7]
          current = [1,6,7]
          current.seq_diff(old).should == {:added => [1,6]}
        end
      end
    end

    describe "removing" do
      context "one at the head" do
        it "works" do
          old = [1,2,3,4,5]
          current = [2,3,4,5]
          current.seq_diff(old).should == {:removed => [1]}
        end
      end

      context "one at the tail" do
        it "works" do
          old = [1,2,3,4,5]
          current = [1,2,3,4]
          current.seq_diff(old).should == {:removed => [5]}
        end
      end

      context "one in the middle" do
        it "works" do
          old = [1,2,3,4,5]
          current = [1,2,3,5]
          current.seq_diff(old).should == {:removed => [4]}
        end
      end

      context "two or more" do
        it "works" do
          old = [1,2,3,4,5]
          current = [1,4,5]
          current.seq_diff(old).should == {:removed => [2,3]}

          old = [1,2,3,4,5]
          current = [2,3,4]
          current.seq_diff(old).should == {:removed => [1,5]}

          old = [1,2,3,4,5]
          current = [2,4]
          current.seq_diff(old).should == {:removed => [1,3,5]}

          old = [1,6,7]
          current = []
          current.seq_diff(old).should == {:removed => [1,6,7]}

          old = [1,6,7]
          current = [6]
          current.seq_diff(old).should == {:removed => [1,7]}
        end
      end

      context "something added" do
        it "works" do
          old = [1,2,3,4,5]
          current = [1,4,5,9,10]
          current.seq_diff(old).should == {:added => [9,10], :removed => [2,3]}
        end
      end
    end

    context "no difference" do
      it "returns empty hash" do
        list = [1,2,3,4,5]
        list.seq_diff(list).should == {}
      end
    end
  end

end

