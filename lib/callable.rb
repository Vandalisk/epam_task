# A special module that is responsible for attitude for ruby class as a service
class Callable
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
