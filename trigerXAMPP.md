
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



<img width="690" height="638" alt="{0573DE99-7293-47E8-BF60-2E0A4D1472AB}" src="https://github.com/user-attachments/assets/16fb7780-42d7-4c54-90be-8116b034c430" />


```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud UPDATE käsk',
concat('vanad : ', OLD.linnanimi, ',',  OLD.rahvaarv, '\n uued: ', NEW.linnanimi, ', ', NEW.rahvaarv)
FROM linnad a INNER JOIN linnad b
ON a.linnID=b.linnID
WHERE a.linnID=NEW.linnID
```


<img width="1010" height="435" alt="{3976962F-6F0F-488C-B7E6-5FD2FAD2F614}" src="https://github.com/user-attachments/assets/c4a83610-1e9c-4448-96e5-ecf6250c4ef1" />







