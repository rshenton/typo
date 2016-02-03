Feature: Merge Articles
    As an admin
    To combine article content
    I want to merge articles

    Background: articles and users have been added to database

        Given the blog is set up

        Given the following users exist:
            | profile_id | login  | password    | email            |
            | 2          | user1  | 1234567     | userone@test.com |
            | 3          | user2  | 1234567     | usertwo@test.com |
    
        Given the following articles exist:
            | id | title        | user_id | body         | published_at        |
            | 3  | ArticleThree | 2       | ContentThree | 2016-02-01 12:00:00 |
            | 4  | ArticleFour  | 3       | ContentFour  | 2016-02-01 12:30:00 |

        Given the following comments exist:
            | id | author | body       | article_id | user_id | created_at          |
            | 1  | user1  | CommentOne | 3          | 2       | 2016-02-01 12:05:00 |
            | 2  | user1  | CommentTwo | 4          | 2       | 2016-02-01 12:35:00 |

    Scenario: A non-admin cannot merge articles
	Given I am logged in as user "user1" with passcode "1234567"
        And I am on the edit article page with id 3
        Then I should not see "Merge Articles"

    Scenario: An admin can merge articles
	Given I am logged in as user "admin" with passcode "aaaaaaaa"
        And I am on the edit article page with id 3
        Then I should see "Merge Articles"
        When I fill in "merge_article" with "4"
        And I press "Merge"
        Then I should be on the admin content page
        And I should see "Articles merged!"

    Scenario: A merged article should contain the text of both previous articles
        Given article ids "3" and "4" have been merged
        And I am on the home page
        Then I should see "ArticleThree"
        When I follow "ArticleThree"
        Then I should see "ContentThree"
        And I should see "ContentFour"
      
    Scenario: A merged article should have one author (either of the original authors)
        Given article ids "3" and "4" have been merged
        Then "user1" should be author of 1 articles
        And "user2" should be author of 0 articles
      
      
    Scenario: A merged article should carry over comments of both previous articles
        Given article ids "3" and "4" have been merged
        And I am on the home page
        Then I should see "ArticleThree"
        When I follow "ArticleThree"
        Then I should see "CommentOne"
        And I should see "CommentTwo"
      
      
    Scenario: A merged article should have one title (either of the original titles)
        Given article ids "3" and "4" have been merged
        And I am on the home page
        Then I should see "ArticleThree"
        And I should not see "ArticleFour"
        
    Scenario: Can not merge article to itself
        Given I am logged in as user "admin" with passcode "aaaaaaaa"
        And I am on the edit article page with id 3
        When I fill in "merge_article" with "3"
        And I press "Merge"
        Then I should be on the admin content page
        And I should see "Articles not merged!"
        
    Scenario: Can not merge article to non-existant article
        Given I am logged in as user "admin" with passcode "aaaaaaaa"
        And I am on the edit article page with id 3
        When I fill in "merge_article" with "0"
        And I press "Merge"
        Then I should be on the admin content page
        And I should see "Articles not merged!"