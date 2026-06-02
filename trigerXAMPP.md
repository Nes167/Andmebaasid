
<img width="683" height="664" alt="{8F1111DF-5CE8-4291-88E7-3730A9857487}" src="https://github.com/user-attachments/assets/f8e99773-95d0-49e9-8b54-d22f84eb89b0" />


```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud INSERT käsk', 
concat('linn: ', NEW.linnanimi, ', rahvaarv: ', NEW.rahvaarv)
FROM linnad
WHERE linnad.linnID=NEW.linnID;
```


<img width="685" height="679" alt="{EB407655-A5F5-40F4-BBD3-BAAEEB3DFEAE}" src="https://github.com/user-attachments/assets/90ad7034-3e46-43c5-b8d2-4eb59f173cf2" />

```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(), 
'on tehtud DELETE käsk',  
concat('linn: ', OLD.linnanimi, ', rahvaarv: ', OLD.rahvaarv)
FROM linnad
WHERE linnad.linnID=OLD.linnID
```


<img width="696" height="684" alt="{65D308BF-D39D-403A-977F-824CF735102C}" src="https://github.com/user-attachments/assets/dbcc946c-b8c1-41ce-825c-650d3786caef" />

```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud UPDATE käsk',
concat('vanad : ', OLD.linnanimi, ',',  OLD.rahvaarv, 'uued: ', NEW.linnanimi, ', ', NEW.rahvaarv)
FROM linnad a INNER JOIN linnad b
ON a.linnID=b.linnID
WHERE a.linnID=NEW.linnID
```

<img width="1001" height="362" alt="{CFF0AB66-8ED1-4586-A8CF-B3B3148E0778}" src="https://github.com/user-attachments/assets/dea375f0-a80b-442c-9551-aebff6fc1448" />






