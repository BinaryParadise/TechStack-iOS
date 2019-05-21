BENCHMARK_SIZE  = {'w' => 375.0, 'h' => 667.0}
DEVICE_SIZES = [
{'w' => 320, 'h' => 568},
{'w' => 375, 'h' => 667},
{'w' => 375, 'h' => 812},
{'w' => 414, 'h' => 736},
{'w' => 414, 'h' => 896}]

class Adaptation
  def self.execute(args)
    if args.length == 0
      puts "Usage:
        CMD [像素]
        "
    else
        puts "标准：#{args[0]}"
        scaleWithWidth(args[0].to_i)
        puts ""
        scaleWithHeight(args[0].to_i)
        puts ""
    end
  end

  # 根据屏宽等比
  def self.scaleWithWidth(pixel)
    w = BENCHMARK_SIZE['w']
    puts "宽度等比："
    DEVICE_SIZES.each do |device|
      dw = device['w']
      scale = device['w']/w
      scale = scale < 0.9 ? 0.9 : scale
      if pixel <= 13 && scale < 1.0
        scale = 1.0
      end
      r = pixel*(scale > 1.1 ? 1.1 : scale)
      puts "  #{device['w']}x#{device['h']} = #{dw < w ? r.ceil : r.floor}（#{r.round(3)}）"
    end
  end

  # 根据屏高等比
  def self.scaleWithHeight(pixel)
    h = BENCHMARK_SIZE['h']
    puts "高度等比："
    DEVICE_SIZES.each do |device|
      dw = device['h']
      scale = device['h']/h
      scale = scale < 0.9 ? 0.9 : scale
      if pixel <= 13 && scale < 1.0
        scale = 1.0
      end
      r = pixel*(scale > 1.1 ? 1.1 : scale)
      puts "  #{device['w']}x#{device['h']} = #{dw < h ? r.ceil : r.floor}（#{r.round(3)}）"
    end
  end
end

Adaptation::execute(ARGV)
