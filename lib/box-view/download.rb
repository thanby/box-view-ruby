module BoxView
  # Provides access to the BoxView Download API. The Download API is used for
  # downloading an original of a document, a PDF of a document, a thumbnail of a
  # document, and text extracted from a document.
  class Download
    THUMBNAIL_MIN_WIDTH  =   16
    THUMBNAIL_MAX_WIDTH  = 1024
    THUMBNAIL_MIN_HEIGHT =   16
    THUMBNAIL_MAX_HEIGHT =  768

    # The Download API path relative to the base API path
    @@path = '/documents'

    # Set the path
    def self.path=(path)
      @@path = path
    end

    # Get the path
    def self.path
      @@path
    end

    # Download a document's original file from BoxView. The file can
    # optionally be downloaded as a PDF, as another filename, with
    # annotations, and with filtered annotations.
    #
    # @param [String] uuid The uuid of the file to download
    # @param [Boolean] is_pdf Should the file be downloaded as a PDF?
    # @param [Boolean] is_annotated Should the file be downloaded with annotations?
    # @param [String, Array<String>] filter Which annotations should be
    #   included if any - this is usually a string, but could also be an array
    #   if it's a comma-separated list of user IDs as the filter
    #
    # @return [String] The downloaded file contents as a string
    # @raise CrocodocError
    def self.document(id, is_pdf=false, is_annotated=false, filter=nil)
      extension = is_pdf ? 'pdf' : 'zip'
      encoding = is_pdf ? :pdf : :zip
      BoxView._request(self.path + "/#{id}/content.#{extension}", 'get', nil, nil, false, encoding)
    end

    # Download a document's extracted text from BoxView.
    #
    # @param [String] uuid The uuid of the file to extract text from
    #
    # @return [String] The file's extracted text
    # @raise CrocodocError
    def self.text(uuid)
      return BoxView::_error('Not supported by Box view API currently', self.name, __method__, response)
    end

    # Download a document's thumbnail from Crocodoc with an optional size.
    #
    # @param [String] uuid The uuid of the file to download the thumbnail from
    # @param [Integer] width The width you want the thumbnail to be
    # @param [Integer] height The height you want the thumbnail to be
    #
    # @return [String] The downloaded thumbnail contents
    # @raise CrocodocError
    def self.thumbnail(uuid, width=THUMBNAIL_MIN_WIDTH, height=THUMBNAIL_MIN_HEIGHT)
      BoxView._request(self.path + "/#{uuid}/thumbnail?width=#{width}&height=#{height}", 'get', nil, nil, false, nil)
    end

  end
end
