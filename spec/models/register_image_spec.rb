require 'spec_helper'

describe RegisterImage do
  it { should ensure_inclusion_of(:orientation).in_array(['left', 'recto','verso']) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image)
    .allowing('image/jpg', 'image/jpeg').rejecting('application/ms-word') 
  }
end
