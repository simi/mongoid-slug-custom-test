require 'spec_helper'

describe "My Page model" do
  let(:model) {Page}
  context "#create" do
    it "will save slug when specified" do
      page = model.create(title: "Hello", custom_slug: "slug")

      expect(page.slug).to eql("slug")
    end

    it "will generate slug when not specified" do
      page = model.create(title: "Hello")

      expect(page.slug).to eql("hello")
    end
  end

  context "#update" do
    it "will change slug when specified" do
      page = model.create(title: "Ahoj", custom_slug: "slug")

      page.custom_slug = "next-slug"
      page.save
      expect(page.slug).to eql("next-slug")
    end

    it "will change slug when updated empty custom slug" do
      page = model.create(title: "Ahoj")

      page.custom_slug = "next-slug"
      page.save
      expect(page.slug).to eql("next-slug")
    end

    it "will change slug when updated title and slug is not specified" do
      page = model.create(title: "Hello")

      page.title = "Another title"
      page.save
      expect(page.slug).to eql("another-title")
    end

    it "will not change slug when updated title" do
      page = model.create(title: "Hello", custom_slug: "custom-slug")

      page.title = "Another title"
      page.save
      expect(page.slug).to eql("custom-slug")
    end

    it "will change slug when updated custom_slug" do
      page = model.create(title: "Hello", custom_slug: "custom-slug")

      page.custom_slug = "next-generation-slug"
      page.save
      expect(page.slug).to eql("next-generation-slug")
    end

    it "will change slug when updated custom_slug and title" do
      page = model.create(title: "Hello", custom_slug: "custom-slug")

      page.title = "generation-slug"
      page.custom_slug = "next-generation-slug"
      page.save
      expect(page.slug).to eql("next-generation-slug")
    end

    it "will change slug when updated custom_slug and title in different order" do
      page = model.create(title: "Hello", custom_slug: "custom-slug")

      page.custom_slug = "next-generation-slug"
      page.title = "generation-slug"
      page.save
      expect(page.slug).to eql("next-generation-slug")
    end
  end
end
