class Callable
  attr_accessor :errors
  attr_reader :result

  def errors
    @errors ||= []
  end

  def fail!
    @result = false
  end

  def success!
    @result = true
  end

  def success?
    @result
  end

  def failure?
    !!@result
  end
end
