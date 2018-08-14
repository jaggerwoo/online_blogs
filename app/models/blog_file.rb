class BlogFile < ApplicationRecord
  # extend Enumerize
  mount_uploader :attachment_file, AttachmentFileUploader

  # enumerize :category, in: [:video, :document], default: 'video'
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

  # NGINX version, serve in public dir
  # def serve_path
  #   return pdf_path.sub(self.class.store_dir_root, '') if category.document?

  #   if File.exist? m3u8_path
  #     m3u8_path.sub(self.class.store_dir_root, '')
  #   else
  #     url.sub(self.class.store_dir_root, '')
  #   end
  # end

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
