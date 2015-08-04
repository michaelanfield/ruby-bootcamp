# Defines days so we can do 30.days
class Fixnum
  # Simple returns itself so that we can create a more fluid DSL syntax e.g 2.days
  def days
    self
  end
end
