RSpec.describe 'rake import:users', type: :task do
  around do |example|
    suppress_stdout do    
      fake_stdin('y', &example)
    end
  end

  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  it 'guards execution with destructive warning' do
    expect(task.prerequisites).to include 'destructive'
  end

  describe 'invocation' do
    let(:filename) { 'some_users.csv' }
    let(:mock_importer) { double('User Importer', import: true) }
    before do
      allow(Import).to receive(:new).and_return(mock_importer)
    end
    after do
      task.reenable
    end

    it 'fails with no filename provided' do
      expect { task.invoke }.to raise_exception Nope
    end

    it 'creates a new User importer' do
      expect(Import).to receive(:new).with(User).once.and_return(mock_importer)
      task.invoke(filename)
    end

    it 'calls the User importer with a pathname' do
      expect(mock_importer).to receive(:import).with(instance_of(Pathname))
      task.invoke(filename)
    end

    it 'calls the User importer with a path to the correct file' do
      expect(mock_importer).to receive(:import) do |pathname|
        expect(pathname.to_s).to end_with filename
      end
      task.invoke(filename)
    end
  end
end
