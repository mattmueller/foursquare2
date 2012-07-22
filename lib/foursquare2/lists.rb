module Foursquare2
  module Lists

    # Retrieve information about a list.
    #
    # @param [String] list_id - The id of the list to retrieve.
    # @param [Hash] options
    # @option options Integer :limit - Number of results to return, up to 200.
    # @option options Integer :offset - The number of results to skip. Used to page through results.

    def list(list_id, options={})
      response = connection.get do |req|
        req.url "lists/#{list_id}", options
      end
      return_error_or_body(response, response.body.response.list)
    end

    # Add a list: See https://developer.foursquare.com/docs/lists/add
    #
    # @param [Hash]  options
    # @option options String :name - (required) The name of the list
    # @option options String :description - The description of the list.
    # @option options Boolean :collaborative - Boolean indicating if this list can be edited by friends.
    # @option options String :photoId - The id of a photo that should be set as the list photo.

    def add_list(options={})
      response = connection.post do |req|
        req.url "lists/add", options
      end
        return_error_or_body(response, response.body.response.list)
    end

    # Follow a list: https://developer.foursquare.com/docs/lists/follow
    #
    # @param [String] list_id - The id of the list to follow.

    def follow_list(list_id)
      response = connection.post "lists/#{list_id}/follow"
      return_error_or_body(response, response.body.response.list)
    end

    # Unfollow a list: https://developer.foursquare.com/docs/lists/unfollow
    #
    # @param [String] list_id - The id of the list to unfollow.

    def unfollow_list(list_id)
      response = connection.post "lists/#{list_id}/unfollow"
      return_error_or_body(response, response.body.response.list)
    end

    # Update a list: https://developer.foursquare.com/docs/lists/update
    #
    # @param [String] list_id - The id of the list to update
    # @param [Hash] options
    # @option options String :name - The name of the list
    # @option options String :description - The description of the list.
    # @option options Boolean :collaborative - Boolean indicating if this list can be edited by friends.
    # @option options String :photoId - The id of a photo that should be set as the list photo.

    def update_list(list_id, options={})
      response = connection.post do |req|
        req.url "lists/#{list_id}/update", options
      end
        return_error_or_body(response, response.body.response.list)
    end

    # Add an item to a list: https://developer.foursquare.com/docs/lists/additem
    #
    # @param [String] list_id - The id of the list to update
    # @param [Hash] options (all optional)
    # @option options String :venueId - A venue to add to the list.
    # @option options String :text - text to add to item
    # @option options String :url - associate a url with the tip
    # @option options String :tipId - Used to add a tip to a list
    # @option options String :listId - Used with itemId to copy item from a list
    # @option options String :itemId - Used with listId to copy item from a list

    def add_list_item(list_id, options={})
      response = connection.post do |req|
        req.url "lists/#{list_id}/additem", options
      end
        return_error_or_body(response, response.body.response.item)
    end

    # Delete an item from a list: https://developer.foursquare.com/docs/lists/deleteitem
    #
    # @param [String] list_id - The id of the list to delete item from
    # @param [String] item_id = The id of the item to delete from list

    def delete_list_item(list_id, item_id)
      response = connection.post do |req|
        req.url "lists/#{list_id}/deleteitem", :itemId => item_id
      end
      return_error_or_body(response, response.body.response.item)
    end

    # Move an item on a list: https://developer.foursquare.com/docs/lists/moveitem
    #
    # @param [String] list_id - The id of the list on which the item is moved
    # @param [String] item_id = The id of the item to move
    # @param [Hash] options
    # @option options String :beforeId - (optional) move itemId before beforeId
    # @option options String :afterId - (optional) move itemId after afterId

    def move_list_item(list_id, item_id, options={})
      response = connection.post do |req|
        req.url "lists/#{list_id}/moveitem", {:itemId => item_id}.merge(options)
      end
      return_error_or_body(response, response.body.response.list)
    end

  end
end
