# Code from brbrr (https://gist.github.com/brbrr/7a97e1b9b8394421e34f)
# I have changed some names and folder paths

require 'rtesseract'
require 'RMagick'
require 'fileutils'

module OCRHelperModule
  def text_in_image?(text, opt = {})
    screens = opt.fetch(:screens, 3)
    delay = opt.fetch(:delay, nil)
    pre_pause = opt.fetch(pre_pause, nil)

    take_multiple_screens(screens, delay, pre_pause)
    recognize_multiple_screens(screens, text)
  end

  # Not tested
  def text_position(text)
    create_screenshot_path
    text = text.to_s unless text.is_a?(String)
    World.screenshot(path: @ocr_screenshots_path,
                     file_name: "txt_#{text.gsub(' ', '_')}.png")
    img = process_image(
      File.join(@ocr_screenshots_path, "txt_#{text.gsub(' ', '_')}.png")
    )
    img2 = img.write(File.join(@ocr_screenshots_path, "changed.png"))

    e = ocr_proc(img2)
    words = ''
    box = e.each_word do |w|
      words << (' ' + w.to_s)
      break w.bounding_box if w.to_s.include?(text)
    end

    x = (box.x + box.width / 2) / 3
    y = (box.y + box.height / 2) / 3
    { x: x, y: y }
  end

  private

  # take multiple screenshots in order to catch the error on the screen
  def take_multiple_screens(circles, delay, pre_pause)
    sleep(pre_pause) unless pre_pause.nil?
    create_screenshot_path
    circles.times do |index|
      World.take_screenshot(path: @ocr_screenshots_path,
                            file_name: "rec_#{index}.png")
      sleep(delay) unless delay.nil?
    end
  end

  def recognize_multiple_screens(circles, text)
    circles.times do |index|
      rec_text = recognize_text_on_pic(
        File.join(@ocr_screenshots_path, "rec_#{index}.png")
      )
      return true if rec_text.include?(text)
    end
    false
  end

  # by default RTesseract gem is used here
  def recognize_text_on_pic(pic_location = nil)
    img = process_image(pic_location)
    tess = RTesseract.new(img)
    tess.to_s # recognize
  end

  def process_image(pic_location)
    img = Magick::Image.read(pic_location).first
    img.contrast.normalize.negate.posterize(3).adaptive_resize(3)
  end

  # tesseract-ocr gem is used here (could get better results)
  def ocr_proc(img)
    Tesseract::Engine.new { |e|
      e.image = img
    }
  end

  # Creating a folder in system tmp to store the screenshots
  def create_screenshot_path
    @ocr_screenshots_path = '/tmp/screen_element/ocr_screenshots'
    FileUtils.rm_r @ocr_screenshots_path if Dir.exist?(@ocr_screenshots_path)
    FileUtils.mkdir_p @ocr_screenshots_path
  end
end
