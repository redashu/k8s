## Fault injection 

### For testing our application we can use fault injection -- Using virtual service 

#### there are two type of fault injection 

<ol>
  <li>delay</li>
  <li>abort</li>
</ol>

<img src="fault.png">

## Timeout --

### Problem 
 <p> Sometime a particular micro service is having slow response so the dependent micro service will also be affect and user will be facing delay in response </p> 
 
### Solution 

<p>We can Introduce timeout so that dependent micro service must not wait they can show some error </p>
<p> we have to write in Virtual service </p>

<img src="time.png">


## Retry 

### Problem 

<p> Generally developers use to write retry logic if one micro service is failing in response </p>
<p> So Istio is offering retry logic so you don't have to add this in code </p>

### solution 

<p> we can introduction retry in virtual service </p>

<img src="retry.png">

## Circuit breaking 

### problem 

<p> If a particular micro service is not responding then the dependent micro service will be having a collection of request </p>
<p> which means requests will be pilled up </p>

### Solution 

<p> if we mark those request to be servered or consumed then this is called circuit breaking </p>
<p> circuit breaker are configured in Destination rules </p>

<img src="cr.png">

### Demo 

<img src="crd.png">






