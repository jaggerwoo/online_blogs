class BlogFile < ApplicationRecord
  mount_uploader :attachment_file, AttachmentFileUploader

  belongs_to :blog

  def pdf_path
    if File.extname(self[:attachment_file]).casecmp('.pdf').zero?
      attachment_file.file.path
    else
      File.join(attachment_file.store_dir, attachment_file.file.basename + '.pdf')
    end
  end

  def m3u8_path
    File.join(attachment_file.store_dir, attachment_file.file.basename + '.m3u8')
  end

  def serve_path
    
  end

  def to_jq_upload
    {
      "name" => read_attribute(:attachment_file),
      "size" => attachment_file.size,
      "thumb_url" => attachment_file.thumbnail_url,
      "download_url" => url,
      "id" => id,
      "filename" => filename,
      "slug" => slug,
      "type" => category
    }
  end

  def filename
    attachment_file.file ? attachment_file.file.original_filename : ""
  end

  def url
    serve_path
  end

  def self.store_dir_root
    File.join(Rails.root, "private")
  end
end
