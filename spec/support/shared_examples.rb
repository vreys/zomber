describe Serial do
  shared_examples_for "#index" do
    it "should return index of the Season" do
      @season.index.should eql(subject)
    end    
  end
end
