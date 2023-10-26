    vlib work
    vmap work
        
    vlog -vopt fifo_sub.v
    vlog -vopt fifo.v
    vlog -vopt rc_multicast_sub.v
    vlog -vopt rc_multicast.v
    vlog -vopt RR_arbiter.v
    vlog -vopt multicast_arbiter.v
    vlog -vopt router.v
    vlog -vopt router_tb.v

    vsim -vopt -voptargs="+acc" work.router_tb

    add wave -r *

    run 1000000us
    
    
