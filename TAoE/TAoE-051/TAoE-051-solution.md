---
#### [Overview](../TAoE--TheArtofError.md) 
---


## TAoE-051 Solution

The Art of Error (TAoE)

### The solution for [TAoE-051](./TAoE-051.md).

#### Main Problem

* Specifying your own font color might not be a good idea, because users will change the system settings (font, color, contrast) to their need. 
  

Try, for example to preview in **Dark Mode** with `.preferredColorScheme(.dark)
`: 

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
}
``` 


#### Main Solution

* Choose default font colors.


- - -

## Some more troubles:

* The contrast might be not as high as expected. Low contrast posed problems to many user groups (people with low vision or other sight impairments).

	

---
#### [Back to the overview](../TAoE--TheArtofError.md) 
---

