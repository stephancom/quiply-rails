RSpec.describe 'rake destructive', type: :task do
  around do |example|
    suppress_stdout(&example)
  end

  it 'has no prerequisites' do
    expect(task.prerequisites).to be_empty
  end

  describe 'warning message' do
    around do |example|
      fake_stdin('y', &example)
    end

    it 'should warn that the task is destructive' do
      expect { task.execute }.to output(/destructive/).to_stdout
    end

    it 'should ask if the user wants to continue' do
      expect { task.execute }.to output(/continue\?/).to_stdout
    end
  end

  describe 'response to input' do
    it 'succeeds when user says y' do
      fake_stdin('y') do
        expect { task.execute }.not_to raise_exception
      end
    end

    it 'succeeds when user says Y (upper case)' do
      fake_stdin('Y') do
        expect { task.execute }.not_to raise_exception
      end
    end

    it 'terminates when user says n' do
      fake_stdin('n') do
        expect { task.execute }.to raise_exception Nope
      end
    end

    it 'terminates when user says N (upper case)' do
      fake_stdin('n') do
        expect { task.execute }.to raise_exception Nope
      end
    end

    it 'terminates when user says neither y nor n' do
      fake_stdin('meh') do
        expect { task.execute }.to raise_exception Nope
      end
    end
  end
end
