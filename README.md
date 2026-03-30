# CPT Machine information


The CPT Corporation made a few word processor machines in the 1970s and 80s. There is information here about specifically the:

4200
8000
8500

CPT 4200
========

This is a TTL (no processor) word processing tool that used a (modified) IBM Selectric for input and output. The 4200 console was a unit with a few keys and two tape decks. Text could be saved on the tapes, together with information such as names and addresses, these could be combined automatically later, creating a mail-merge facility.

CPT8000
=======
The 8000 is an 8080 based word processing system. It uses floppy drives for storage.

CPT8500
=======

The 8500 is an 8000 in a condensed form. The circuitry from the 8000 has been squashed down onto a smaller number of PCBs.

8000 Re-creation
================

I have a set of CPT8500 PCBs, but nothing else. I'm planning on recreating the parts I need in order to get the boards running again.

The backplane is the first part needed, this has been designed and is untested:

<img width="1081" height="1149" alt="front-render" src="https://github.com/user-attachments/assets/82faf523-eaeb-4224-9492-03d5facf1d06" />
<img width="1060" height="1302" alt="back-render" src="https://github.com/user-attachments/assets/5f69b55c-5716-46a5-a6f2-c52ea1d82c18" />

I've also designed a diagnostic/debug card (untested) which is a Pico on a bus:

<img width="800" height="1105" alt="cptdiag" src="https://github.com/user-attachments/assets/9e59a69a-0107-48d5-b5b1-4b3076cb1098" />

Acknowledgements
================

Thanks to Adrian at Binary Dinosaurs, who has helped a lot with data from his real CPT machine.
Rich, who used to work at CPT has generously scanned and supplied the chematics of the 8000, without which these projects would not have started.

