# Modeling-Nature-Interactions
Here I will store Pov-Ray scripts and -approaches for modeling structures with interacting elements. 
I will look at three different kinds of interactions: (1) Interactions modifying the location and/or orientation of elements, (2) interactions modifying the shape of elements and (3) interactions modifying the texture (colour) of elements. 
Let's start with a simple example for (1). Elements are only displayed when they are inside a given larger elment. This kind of interactions can be easily modeled in Pov-Ray using the inside-funktion - here are a few examples. 
![A2](https://github.com/user-attachments/assets/cbbb15b7-a931-4d5c-a0bc-db1e5ae35a44)
![IT3](https://github.com/user-attachments/assets/2c453f63-9948-463e-8db2-00c66f48a3ba)
![InsideLove](https://github.com/user-attachments/assets/77787743-1f1c-4d1c-b21b-cabdf455f2e4)
Using the inside function it is also possible to place objects on the surface of a large object by first spreading them around the object, and then making them move towards the object until they reach the surface. ![envelopeb](https://github.com/user-attachments/assets/49971bd1-b205-4e77-b5ee-24fbd03467ba)
The next form of interactions refers to the orientation of a given object. In the next examples I will show how to orientate the objects according to the normal of the surface of the larger object. (In this example the large object is a virus and the small particles are viral proteins. 
![enveloped2](https://github.com/user-attachments/assets/2be94293-052d-4013-b340-ab3a62c6dc58)
![Influenza3](https://github.com/user-attachments/assets/17f2f7c7-098b-4a9c-8f86-b1e2bbd57e11)
There are also cases where one element determines location (and eventually orientation of a subsequent element. Worms (for example) can be modeled this way in a stepwise process. 
![Wormstart](https://github.com/user-attachments/assets/384930ae-e159-4b37-85d3-bd4f9ac55e88)
![SimpleWorm](https://github.com/user-attachments/assets/5787c69f-546c-4e59-bfc0-06bef65cf6a4)
By modifying the shape of individual elements different kinds of worms are possible:
![ThickWorm](https://github.com/user-attachments/assets/297642ce-ad82-44dd-9080-e9ea513ddafe)
![FlatWorm](https://github.com/user-attachments/assets/77f6fd98-8a23-42ad-8337-521fbd3951b4)
But also Anabaena filaments can be modeled by stepwise addition of elements to a growing chain.
![Anabaena1](https://github.com/user-attachments/assets/c3f50c76-5e69-4fc4-bb11-19e8d2612477)
![Anabaena2](https://github.com/user-attachments/assets/9475954e-e185-4a60-8c19-b2b3b310f07b)
Below I will show you a few examples, where elements modify each others shape. We start with soap bubbles (simple models for cells) and end with plant cells. 
![SoapBubble1](https://github.com/user-attachments/assets/a939973a-262a-4da4-b15b-eba4bd157a5a)
![SoapBubble2](https://github.com/user-attachments/assets/f9b2d970-b4a1-4a05-9ff3-07357ccaf96d)
![SoapBubble3](https://github.com/user-attachments/assets/760ef828-dc3e-42e5-8d9d-9179a7ac4cfa)
![Honeycomb](https://github.com/user-attachments/assets/9b1a8a34-99b4-4792-9523-5d00ff367b41)
![PlantCells1](https://github.com/user-attachments/assets/97ec9527-5051-4a40-9261-6c38e940286e)
![PlantCells2](https://github.com/user-attachments/assets/84e26bd5-1de8-4595-b201-2f0b1ef2bf19)
![PlantCells3](https://github.com/user-attachments/assets/710eebe9-32ce-4f67-a467-a1f1d78c477f)
![PlantCells4](https://github.com/user-attachments/assets/a9e7b4e2-b1b4-4ad1-9c3a-d9013b875687)
Cellular automata basically are elements where interactions modify the texture of other elements. I did not go very far in this field. Since it is an important field, however, I wanted to include at least one example. The two following pictures are frames from such interactions. Let the first frame be a random distribution of 1 (orange colour) and 0 (blue colour). In the subsequent frame I have applied the rule that 1 is only kept for fields surrounded by at least 3 orange elements. In the Pov-Ray file added here you can do as many steps using this rule as you want. Unfortunately it is not a very interesting rule resulting in disappearance of the the orange elements after some time. Feel free to play around with other rules!
![Frame1](https://github.com/user-attachments/assets/f991ab8d-8022-46bf-aeab-13ac31b7c59c)
![Frame2](https://github.com/user-attachments/assets/65613f6c-f2b2-4144-9778-53fc6604f799)
