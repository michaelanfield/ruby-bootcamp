require 'pry'

describe Exercise9::Robot do

	subject { described_class.new('Tin man') }

	it_behaves_like Exercise9::Speech, ['HeLLo', 'wOrld']
	it_behaves_like Exercise9::Moveable
end