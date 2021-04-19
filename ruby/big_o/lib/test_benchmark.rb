require "benchmark"
require_relative "window"

arr = (1..500000).to_a.shuffle

if __FILE__ == $PROGRAM_NAME
  Benchmark.bm(7) do |x|
    x.report("dumb: ") { windowed_max_range(arr, 3) }
    x.report("queue: ") { queue_windowed_range(arr, 3) }
    x.report("squeue: ") { sq_windowed_range(arr, 3) }
    x.report("mmsq: ") { mmsq_windowed_range(arr, 3) }
  end
end