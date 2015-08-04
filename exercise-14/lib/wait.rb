# Provides a single method `until`, which will wait until the supplied block is true.
#
# The method supports the following options to be supplied as a Hash.
#  * :retry_time - defines the amount of time the process will leave between block exceutions (defaults to 0).
#  * :expire_after - defines the time out period for the execution of the block (defaults to 5 seconds).
#  * :debug - outputs the number of attempts if set to true (defaults to false).
#
# Example use;
#
#  Wait.until(:retry_time => 0.01, :expire_after => 10, :debug => true ) { rand(999) % 2 == 0 }
#
# throws Wait::NoBlockGivenError if no block is supplied.
# throws Wait::TimeOutError if the expire_after time is exceeded.
#
# Author : michael.anfield
# Date   : 21 Jul 2015
module Wait
  def self.until(options = {}, &_block)
    fail NoBlockGivenError, 'You muppet! Please supply a block to execute.' unless block_given?

    retry_time = options.delete(:retry_time) || 0
    expire_after = options.delete(:expire_after) || 5
    debug = options.delete(:debug) || false

    start_time = Time.now

    outcome = yield
    attempt = 1

    until outcome
      current_time = Time.now

      fail TimeOutError, "Timed out waiting, #{expire_after} seconds elapsed" if current_time - start_time >= expire_after

      sleep(retry_time)

      outcome = yield
      attempt += 1
    end

    p "It took #{attempt} attempt(s)." if debug

    outcome
  end

  class NoBlockGivenError < StandardError; end

  class TimeOutError < StandardError; end
end
