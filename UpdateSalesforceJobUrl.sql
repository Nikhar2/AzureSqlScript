USE ${Environment}Trees
UPDATE Setting
SET Value = 'https://balsambrands--${Environment}.my.salesforce.com/services/async/48.0/job'
WHERE Name = 'SalesForceJobUrl';
GO

USE ${Environment}International
UPDATE Setting
SET Value = 'https://balsambrands--${Environment}.my.salesforce.com/services/async/48.0/job'
WHERE Name = 'SalesForceJobUrl';
GO