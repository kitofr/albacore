require 'albacore/paths'

describe ::Albacore::Paths.method(:join), 'when joining path segments' do
  let :s do
    Paths.separator
  end

  let :sample do
    subject.call(*%w|a b c|)
  end

  let :abc do
    'a' + s + 'b' + s + 'c'
  end

  it 'should return id' do
    subject.call('abc').to_s.should eq('abc')
  end 

  it 'should return with proper separator' do
    sample.to_s.should eq('a' + s + 'b' + s + 'c')
  end

  it 'should be joinable' do
    sample.join('d').to_s.should include(s)
  end

  it 'should be +-able' do
    (sample + 'd').to_s.should include(s)
  end

  it 'can join with *' do
    subject.call('a').join('*/').to_s.should eq('a' + s + '*' + s)
  end

  it 'accepts multiple paths' do
    subject.call('a', 'b', 'c').to_s.should eq(abc)
  end

  it 'returns something accepting multiple paths' do
    subject.call('a', 'b', 'c').join('d', 'e').to_s.should eq(abc + s + 'd' + s + 'e')
  end

  it 'should be presentable in "unix" style' do
    sample.as_unix.to_s.should_not include('\\')
  end
end

describe ::Albacore::Paths.method(:join_str), 'when joining path segments' do
  let :s do
    Paths.separator
  end

  it 'id' do
    subject.call('.').should eq('.')
  end

  it 'id slash' do
    subject.call('.', '/').should eq(s)
  end

  it 'id slash win' do
    subject.call('.', '\\').should eq(s)
  end

  it 'id slash with root' do
    subject.call('.', '/', '/b').should eq(s + 'b')
  end

  it 'id slash with root win' do
    subject.call('.', '\\', '\\b').should eq(s + 'b')
  end

  it 'id double slash' do
    subject.call('.', 'b/', 'c/').should eq('b' + s + 'c' + s)
  end

  it 'id double slash win' do
    subject.call('.', 'b\\', 'c\\').should eq('b' + s + 'c' + s)
  end
end

