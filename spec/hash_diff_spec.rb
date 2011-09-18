require 'spec_helper'

describe Hash do
  describe "#detailed_diff" do
    describe "adding" do
      context "one at the head" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          addition = {12 => {"id" => 12, "title" => "Super Mario Bros"}}
          current = old.merge(addition)
          current.detailed_diff(old).should == {:added => addition}
        end
      end
      context "one at the tail" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          addition = {255 => {"id" => 255, "title" => "Super Mario Bros"}}
          current = old.merge(addition)
          current.detailed_diff(old).should == {:added => addition}
        end
      end
      context "one in the middle" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          addition = {200 => {"id" => 200, "title" => "Nyan Cat"}}
          current = old.merge(addition)
          current.detailed_diff(old).should == {:added => addition}
        end
      end
      context "two"
    end

    describe "changing" do
      context "one at the head" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          changed = {123 => {"id" => 123, "title" => "Nyan Cat"}}
          current = old.merge(changed)
          current.detailed_diff(old).should == {:added => changed}
        end
      end
      context "one at the tail" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          changed = {255=> {"id" => 255, "title" => "Nyan Cat"}}
          current = old.merge(changed)
          current.detailed_diff(old).should == {:added => changed}
        end
      end
      context "one in the middle" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 129 => {"id" => 129, "title" => "Gintama Season 2 Ep 200"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          changed = {129 => {"id" => 129, "title" => "Nyan Cat"}}
          current = old.merge(changed)
          current.detailed_diff(old).should == {:added => changed}
        end
      end
      context "two or more" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 129 => {"id" => 129, "title" => "Gintama Season 2 Ep 200"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          changed = {129 => {"id" => 129, "title" => "Nyan Cat"},
                     255 => {"id" => 255, "title" => "Just Follow Law"}}
          current = old.merge(changed)
          current.detailed_diff(old).should == {:added => changed}
        end
      end
      context "something added" do
        it "works" do
          old = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                 129 => {"id" => 129, "title" => "Gintama Season 2 Ep 200"},
                 255 => {"id" => 255, "title" => "Super Mario Bros"}}
          changed = {129 => {"id" => 129, "title" => "Nyan Cat"},
                     255 => {"id" => 255, "title" => "Just Follow Law"}}
          added = {234 => {"id" => 234, "title" => "Gintama Hangul Version"}}
          current = old.merge(changed).merge(added)
          current.detailed_diff(old).should == {:added => changed.merge(added)}
        end
      end
    end

    describe "removing" do
      context "one at the head" do
        it "works" do
          removed = {12 => {"id" => 12, "title" => "Super Mario Bros"}}
          current = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          old = current.merge(removed)
          current.detailed_diff(old).should == {:removed => removed}
        end
      end
      context "one at the tail" do
        it "works" do
          removed = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          current = {12 => {"id" => 12, "title" => "Super Mario Bros"},
                     111 => {"id" => 890, "title" => "Dora the Explorer"}}
          old = current.merge(removed)
          current.detailed_diff(old).should == {:removed => removed}
        end
      end
      context "one in the middle" do
        it "works" do
          removed = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          current = {12 => {"id" => 12, "title" => "Super Mario Bros"},
                     890 => {"id" => 890, "title" => "Dora the Explorer"}}
          old = current.merge(removed)
          current.detailed_diff(old).should == {:removed => removed}
        end
      end
      context "two" do
        it "works" do
          current = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          removed = {12 => {"id" => 12, "title" => "Super Mario Bros"},
                     890 => {"id" => 890, "title" => "Dora the Explorer"}}
          old = current.merge(removed)
          current.detailed_diff(old).should == {:removed => removed}
        end
      end
      context "something added and changed" do
        it "works" do
          removed = {12 => {"id" => 12, "title" => "Super Mario Bros"},
                     890 => {"id" => 890, "title" => "Dora the Explorer"}}
          added = {55 => {"id" => 55, "title" => "Hahaha"},
                   123 => {"id" => 123, "title" => "Gintama the movie"}}

          current = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"}}
          old = current.merge(removed)
          current.merge!(added)
          current.detailed_diff(old).should == {:removed => removed,
            :added => added}
        end
      end
    end

    context "no difference" do
      it "returns empty hash" do
        list = {123 => {"id" => 123, "title" => "Gintama Season 1 Ep 100"},
                129 => {"id" => 129, "title" => "Gintama Season 2 Ep 200"},
                255 => {"id" => 255, "title" => "Super Mario Bros"}}
        list.detailed_diff(list).should == {}
        {}.detailed_diff({}).should == {}
      end
    end
  end

end
