class Spec::Rake::SpecTask
  def read_opts(filename)
    IO.readlines(filename).map {|l| l.chomp.split ' ' }.flatten
  end
end