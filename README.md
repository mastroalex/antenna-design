# Design of folded patch

**Wireless Electromagnetic Technologies** - University of Rome Tor Vergata

<p align="center">
<img src="https://www.baicr.it/wp-content/uploads/2017/06/Logo_Tor_Vergata-1.png" alt="Tor Vergata" style="width:20%; border:0;">
</p>


> Blasi Luca<br>
> Mastrofini Alessandro<br>
> Mucenica Leonard Stefan
---

## To-Do

* [x] Tcheb. factor
* [ ] Ottimizzazione mesh 
* [ ] Controllare patch
* [ ] Ottimizzazione parametri 


# Note

<<<<<<< Updated upstream
Prova formula: $\oint a\times \underline B$
=======
$\oint a\times \underline B$ 

>>>>>>> Stashed changes

# Requirements

## A. Design a Tchebyshev array factor of five elements with a main lobe / side lobe ratio of R=120. Optimize the inter-element spacing to minimize the beamwidth
1.	Determine the current coefficients (normalized to maximum)
2.	Evaluate the array tapering efficiency.
3.	Evaluate the beamwidth of the array factor and compare with a uniform array
4.	Plot the array pattern (rectangular and polar diagrams)


## B. Design a rectangular folded (λ/4) patch fed by a coaxial cable for (2.0+n0.1) GHz , whose size is compatible with the inter-antenna distance derived above
1.	Use the FR-4 Substrate (available thickness: { 0.8, 1.0, 1.6) mm)
2.	Evaluate by equations the size (L, W), directivity, BW, position of the feed to match 50 ohm.
3.	Refinement with Matlab MoM. Plot currents, impedances, reflection coefficient and gain patterns.

<<<<<<< Updated upstream
=======
The optimal inter-spacing $d$ is computed inside the interval $\left(\frac{\lambda}{2},\lambda\right]$. In this interval, the coefficients of 

$x=a+b\cos(k_0d)$

are $a=\frac{x_1-1}{2}$ and $b=\frac{x_1+1}{2}$ 

$d_{\max}=\lambda\left(1-\frac{1}{2\pi}\arccos\left(\frac{3-x_1}{1+x_1}\right)\right)$

1. Determine the **current coefficients** (normalized to maximum)
	
	* $C_0 = 2a^2+b^2-1 = 41.2$
	* $C_1 = 2ab = 29.8$
	* $C_2 = \frac{a^2}{2} = 5.7$

Being $C_0=C_{\max}$, let's normalize in terms of $C_0$. Since we have 5 patches in the array, the coefficients are distributed as follows:

$[0.1393\qquad0.7215\qquad 1.0000\qquad 0.7215\qquad 0.1393	]$

Let's evaluate $\frac{C_{\max}}{C_{\min}} = \frac{C_0}{C_2} = 7.180$. It means the radiation pattern is highly influenced by the dominating element ($C_0$).  

2. Evaluate the array **tapering efficiency**:

$\eta_T=\frac{1}{N}\frac{|C_0+2C_1+2C_2|^2}{C_0^2+2C_1^2+2C_2^2}=71$%

It means that only 71% of the array is being optimally used to generate radiated field. 

3. Evaluate the **beamwidth** of the array factor and compare it with a uniform array

$BW_{fn}°(Tcheb)=2\frac{180}{\pi}\left(\frac{\pi}{2}-\arccos\left(\frac{arccos\left(\frac{\cos\left(\frac{\pi}{2N}-a\right)}{b}\right)}{k_0d}\right)\right)=50.6°$ in the Tchebyshev analysis. 

$BW_{fn}°(unif)=\frac{2\lambda}{N d}\frac{180}{\pi}=34.8$

Thus $BW_{fn}°(Tcheb) < BW_{fn}°(unif)$

4. Plot the array pattern (rectangular and polar diagrams)
## B
>>>>>>> Stashed changes

## C. Evaluate the performance of the overall array of patches in both broadside case and 45° off the boresight direction (PSI= 90°-45°)
1.	Identify phase coefficients for beam-steering
2.	Compute and plot the total array gain by using the pattern multiplication principle
3.	Compute and plot the total array gain by mean of a fullwave model of the array with Matlab MoM.
4.	Plot of the near field just over the array plane to analyze the fringing field from the edges and observe possible non-uniformity due to the inter-antenna coupling.
