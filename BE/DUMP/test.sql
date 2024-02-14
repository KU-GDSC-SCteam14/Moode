INSERT INTO User (Name, Signup_date, is_Google, is_Apple, Provider_ID, Access_Token, Refresh_Token, Token_Expiry_Date, Profile_Picture_URL)
VALUES ('Testname', '2024-02-13 12:00:00', True, False, 'test_provider_id', 'test_access_token', 'test_refresh_token', '2024-02-13 12:00:00', 'test_profile_picture_urla');

SELECT * FROM User WHERE Name = 'Testname' AND Signup_date = '2024-02-13 12:00:00';

DELETE FROM User WHERE User_ID = 14 AND Signup_date = '2024-02-13 12:00:00';
