/* Very simple funnel to narrow from 100mm output of the 
 * official ventilation model from Bambu down to the 30mm 
 * required by the smaller tubes I'm using. */
rotate_extrude($fa=1)
    import("res/ventilation-funnel.svg");