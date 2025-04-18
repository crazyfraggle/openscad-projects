# Common components

These are reusable components I use across various projects.

## Logo 45

Our quirky little in-house print logo that I tend to stamp on most projects to show they were made by us.

## Box With Lid

This creates a rounded box with a lid and solid inside.
If made solid, the idea is that the inside should be subtracted with the contour of what is to be held in the box.
The output will be the box, specified from origin, and the lid next to it.

### Parameters

| Parameter         | Type      | Default      | Description                                                                                                              |
| ----------------- | --------- | ------------ | ------------------------------------------------------------------------------------------------------------------------ |
| `dimensions`      | `[x,y,z]` | `[40,40,20]` | Inner dimensions: x = front, y = depth, z = total height. Walls are added outside these values.                          |
| `wall`            | `number`  | `2`          | Thickness of lid, lid edge, and hollow box walls.                                                                        |
| `use_logo`        | `bool`    | `true`       | Whether to add the logo to the box.                                                                                      |
| `solid`           | `bool`    | `true`       | If true, box is solid inside. If false, box is hollow with double wall thickness (lid has single wall).                  |
| `inner_tolerance` | `number`  | `2`          | Distance between lid and top of box on the inside. Increase to accomodate pieces inside that stick out of the inner box. |
| `lid_overlap`     | `number`  | `5`          | Amount the lid overlaps the box.                                                                                         |
