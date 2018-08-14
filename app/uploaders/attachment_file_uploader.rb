class AttachmentFileUploader < CarrierWave::Uploader::Base
  # include CarrierWave::MimeTypes
  # when adding white list type, please also add the according type cover image
  DOC_EXTENSION_LIST = %w(pdf)
  VIDEO_EXTENSION_LIST = %w(mp4)

  # after :store, :convert_to_hls
  # after :store, :convert_to_pdf

  process :gen_and_save_file_slug

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    if model.category.video?
      VIDEO_EXTENSION_LIST
    else
      DOC_EXTENSION_LIST
    end
  end

  def store_dir
    "#{BlogFile.store_dir_root}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    original_filename
  end

  def download_link
    "/#{model.class.to_s.underscore.downcase.pluralize}/#{model.id}/view/#{model.slug}"
  end

  def thumbnail_url
    thumbnail = 'attachment_thumbnails/file.png'

    if VIDEO_EXTENSION_LIST.include?(file.extension.downcase)
      thumbnail = "attachment_thumbnails/video.png"
    elsif DOC_EXTENSION_LIST.include?(file.extension.downcase)
      thumbnail = "attachment_thumbnails/#{file.extension.downcase}.png"
    end

    ActionController::Base.helpers.asset_path(thumbnail)
  end

  private

  def gen_and_save_file_slug
    model.slug = SecureRandom.uuid.delete('-')
  end

  def convert_to_hls(xyz)
    puts xyz
    return unless model.category.video?

    TrainCourse::ConvertToHlsWorker.perform_async(model.id)
  end

  def convert_to_pdf(xyz)
    puts xyz
    return unless model.category.document?
    return if File.extname(file.file).casecmp('.pdf').zero? &&
              Rails.logger.info('>> uploaded document is already a pdf.')
    return if Rails.application.secrets.doc_converter_url.blank? &&
              Rails.logger.debug('>> doc converter url not exists.')

    TrainCourse::ConvertToPdfWorker.perform_async(model.id)
  end
end
