Feature: Categories
    As an admin
    To organize articles
    I want to create and edit categories
    
    Background:
        Given the blog is set up
        And I am logged into the admin panel
        When I follow "Categories"
    
    Scenario: load page
        Then I should see "Categories"
        And I should see "Name"
        And I should see "Title"
        And I should see "Description"
        And I should see "Permalink"
        And I should see "Keywords"
        
    Scenario: create category
        When I fill in "Name" with "create_name"
        And I fill in "Keywords" with "create_keywords"
        And I fill in "Permalink" with "create_permalink"
        And I fill in "Description" with "create_description"
        And I press "Save"
        Then I should see "create_name"
        And I should see "create_keywords"
        And I should see "create_permalink"
        And I should see "create_description"
        And I should see "no articles"
        
    Scenario: edit category
        When I follow "General"
        And I fill in "Name" with "edit_name"
        And I fill in "Keywords" with "edit_keywords"
        And I fill in "Permalink" with "edit_permalink"
        And I fill in "Description" with "edit_description"
        And I press "Save"
        Then I should see "edit_name"
        And I should see "edit_keywords"
        And I should see "edit_permalink"
        And I should see "edit_description"