---Case 1
USE ENTVStore
SELECT
	st.StaffID,
	st.StaffName,
	vn.VendorName,
	[Total Transaction] = COUNT(dpt.PurchaseTransactionID)
FROM
	DetailPurchaseTransaction dpt JOIN Television tv ON tv.TelevisionID = dpt.TelevisionID 
	JOIN PurchaseTransaction pt ON pt.PurchaseTransactionID = dpt.PurchaseTransactionID 
	JOIN Vendor vn ON vn.VendorID = pt.VendorID 
	JOIN Staff st ON st.StaffID = pt.StaffID
WHERE
	pt.PurchaseTransactionDate > '2021-08-01' AND st.StaffName LIKE 'B%'
GROUP BY st.StaffId, st.StaffName, vn.VendorName

---Case 2
USE ENTVStore
SELECT
	RIGHT(cs.CustomerID,3) AS [CustomerID],
	cs.CustomerName,
	dst.SalesQuantity * tv.TelevisionPrice AS [Total Spending]
FROM
	Customer cs JOIN SalesTransaction st ON st.CustomerID = cs.CustomerID 
	JOIN DetailSalesTransaction dst ON st.SalesTransactionID = dst.SalesTransactionID 
	JOIN Television tv ON dst.TelevisionID = tv.TelevisionID
WHERE
	cs.CustomerName LIKE '%a%' AND TelevisionName LIKE '%LED%'

---Case 3
SELECT
	LEFT(sta.StaffName, CHARINDEX(' ',sta.StaffName)) AS [Staff Name],
	tv.TelevisionName,
	tv.TelevisionPrice * dst.SalesQuantity AS [Total Sales]
FROM
	DetailSalesTransaction dst JOIN Television tv ON tv.TelevisionID = dst.TelevisionID 
	JOIN SalesTransaction st ON st.SalesTransactionID = dst.SalesTransactionID 
	JOIN Staff sta ON st.StaffID = sta.StaffID
WHERE
	TelevisionName LIKE '%UHD%' 
GROUP BY sta.StaffName, tv.TelevisionName,tv.TelevisionPrice,dst.SalesQuantity
HAVING COUNT(tv.TelevisionName) > 1

---Case 4
SELECT
	UPPER(tv.TelevisionName) AS [Television Name],
	CONCAT(MAX(dst.SalesQuantity),' Pcs') AS [Max Television Sold],
	CONCAT((dst.SalesQuantity),' Pcs') AS [Total Television Sold]
FROM
	DetailSalesTransaction dst JOIN Television tv ON tv.TelevisionID = dst.TelevisionID 
	JOIN SalesTransaction st ON st.SalesTransactionID = dst.SalesTransactionID 
WHERE
	tv.TelevisionPrice > 3000000 AND st.SalesTransactionDate >= '2021-03-01'
GROUP BY tv.TelevisionName,dst.SalesQuantity
ORDER BY [Total Television Sold] ASC

---Case 5
