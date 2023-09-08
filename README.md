![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)
# CDMA diagram description
The diagram is conformed in a single verilog file, it contains the following.
  * Gold code sequence generator.
  * A comparator to detect if we have a valid seed at the input Seed_i [3:0]
  * An XOR gate for the Modulus 2 addition between the Gold code sequence generetor and the signal to transmit signal_i.
  * An XOR gate for the Modulus 2 addition between the Gold code sequence generetor and the recieved signal receptor_i.
  * A buffer to disconnect the CDMA_o if we input an invalid seed.
  * The system has the following inputs
    * clk for the LSFR within the Gold sequence generator.
    * set_i in order to load the seed into the LSFRs.
    * signal_i is the input for the digital signal we are trying to transmit through CDMA.
    * Seed_i [3:0] is the seed to load into the LSFRs.
    * receptor_i is the input for the recieved signal obtained through the channel in order to decode it.
  * The system has the following outputs
      * LED_o it works as a simple indicator telling the user if it can transmit or not.
      * CDMA_o it is the output of the generated CDMA signal.
      * Gold_o is the output to observe the generated Gold code sequence.
      * receptor_o is the output of the decoded recieved signal from receptor_i
## Diagram 
 ![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/8cad173a-e757-4e7d-aeec-0cc5b74c1710)




# Objectives
 * Study the spread-spectrum signal traveling throughout a simulated channel composed of analogic devices such as an OPAM in order to add noise to the transmited signal CDMA.
 * Observe the Gold sequence generator with an osciloscope.
 * Apply the knowledge obtained throught the Latinpractice initiative Bootcamp.
 * Generate a GDS file of the mentioned device.

# CDMA
It is a type of digital communication device in which each pair of user transmitter-receiver has its own unique signature code in order to transmit over a single common bandwidth known as CDMA (Code Division Multiple Access). This principle is thanks to an upgrade in performance obtained through the spread-spectrum achieved by the coding gain and the processing. This allows multiple spread-spectrum signals to travel through the same channel as long as each signal has its own pseudorandom sequence, which in this case is generated by the Gold sequence generator (Jhon G. y Masoud, 2002, p.744).

# Generation of pseudorandom signal or pseudonoise (PN)

A pseudo-random sequence or pseudonoise is a string of codes formed by 1 and 0, whose autocorrelation has properties similar to those of white noise (Jhon G. & Masoud, 2002, p.748).
The most well-known way to generate pseudonoise signals is through a sequence with maximal length shift registers, also known as m-sequences.
These sequences have a length and period of L = 2^m − 1, where m is the number of used registers, which have linear feedback.

# Gold sequences
A typical implementation of a Gold code is achieved through two shift registers of length m with linear feedback of length m (LSFR). These are configured in such a way that they generate two distinct m sequences. Since it is not possible to initialize the registers with null or zero values, they must be initialized with an initial value known as a seed (one for each linear shift register preferably). This seed provides an option for generating a Gold sequence. The folowing picture contains the hardware implementation of a Gold code sequence generator.

![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/335b5416-5360-4859-8c7e-ed5129809fb4)




It's worth mentioning that not all Gold sequences have good correlation properties. The following table contains the desired pairs to generate a Gold sequence that exhibits favorable correlation properties (Mathuranathan, 2020).

![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/1ac48eee-f862-4f32-ad2d-1d34327463d0)



# Hardware implementation of Gold Sequence generators.
An example hardware implementation for generating a Gold code of length 127 using the preferred pairs ([7,3,2,1],[7,3]) is illustrated in the following picture. Here, each register in the LFSR is a D flip-flop, all connected in cascade and operating with a synchronous clock signal. Altering the initial seed values in the shift registers results in a distinct set of Gold codes (Mathuranathan, 2020).

![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/ce2a57d5-ab79-49c1-9ba8-8a47040f32a6)




This sequence is generated by the modulo-2 sum of the two sequences, and this operation can be performed using the XOR gate ⊕ (Jhon G. & Masoud, 2002, p.751).

# Generation of CDMA signals and the spread-spectrum.
Once the device that generates the pseudonoise (PN) is obtained, generating the CDMA signal requires considering the period of the Gold code and the signal to be transmitted. The period of the Gold code is equal to the maximum length of the sequence, L = 2^m − 1, meaning it takes L clock cycles to generate this sequence.

To generate a CDMA signal, it's necessary to maintain 1 bit of information [0 or 1] for the number of clock cycles needed to generate the Gold sequence and perform the modulo-2 sum of the signal and the Gold sequence. This process is depicted in the next picture (Hapo, 2021). This process is what we call spread-spectrum, this is because 1 bit of information is modulo-2 added into the Gold code sequence.
![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/2a6e1cfa-2743-4386-a678-838ab59bb8c4)


#Simulation on Modelsim

![Alt text](https://github.com/Santiago-Robledo/tt04-submission-template_santiago/assets/143015883/1ebcd0b1-0ea0-47fb-84d8-5ed0224c5fb8)



# Bibliography
 * Proakis, J., & Salehi, M. (1994). Communication Systems Engineering. 
 * Mathuranathan. (2020, 21 noviembre). Gold Code Generator using LFSRs - GaussianWaves. GaussianWaves. https://www.gaussianwaves.com/2015/06/gold-code-generator/
 * Hapo. (2021). ¿Qué son las redes inalámbricas CDMA y cómo funcionan? BigHardware. https://bighardware.es/que-son-las-redes-inalambricas-cdma-y-como-funcionan/
 

# What is Tiny Tapeout?

TinyTapeout is an educational project that aims to make it easier and cheaper than ever to get your digital designs manufactured on a real chip!

Go to https://tinytapeout.com for instructions!

## How to change the Wokwi project

Edit the [info.yaml](info.yaml) and change the wokwi_id to match your project.

## How to enable the GitHub actions to build the ASIC files

Please see the instructions for:

- [Enabling GitHub Actions](https://tinytapeout.com/faq/#when-i-commit-my-change-the-gds-action-isnt-running)
- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## How does it work?

When you edit the info.yaml to choose a different ID, the [GitHub Action](.github/workflows/gds.yaml) will fetch the digital netlist of your design from Wokwi.

After that, the action uses the open source ASIC tool called [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/) to build the files needed to fabricate an ASIC.

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://discord.gg/rPK2nSjxy8)

## What next?

- Submit your design to the next shuttle [on the website](https://tinytapeout.com/#submit-your-design), the closing date is 8th September.
- Share your GDS on Twitter, tag it [#tinytapeout](https://twitter.com/hashtag/tinytapeout?src=hashtag_click) and [link me](https://twitter.com/matthewvenn)!
