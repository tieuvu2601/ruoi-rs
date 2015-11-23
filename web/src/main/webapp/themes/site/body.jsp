<%@ include file="/common/taglibs.jsp" %>
<div class="content container">
    <div id="promo-slider" class="slider flexslider">
        <ul class="slides">
            <li>
                <img src="<c:url value="/themes/site/images/slides/slide-1.jpg"/>"  alt="" />
                <p class="flex-caption">
                    <span class="main" >Join College Green Online</span>
                    <br />
                    <span class="secondary clearfix" >Choose from over 100 online and offline courses</span>
                </p>
            </li>
            <li>
                <img src="<c:url value="/themes/site/images/slides/slide-2.jpg"/>"  alt="" />
                <p class="flex-caption">
                    <span class="main" >Come to our Open Days</span>
                    <br />
                    <span class="secondary clearfix" >Donec accumsan nunc sed ipsum dapibus consectetur</span>
                </p>
            </li>
            <li>
                <img src="<c:url value="/themes/site/images/slides/slide-3.jpg"/>"  alt="" />
                <p class="flex-caption">
                    <span class="main" >Discover online courses</span>
                    <br />
                    <span class="secondary clearfix" >Lorem ipsum dolor sit amet, consectetur adipiscing elit</span>
                </p>
            </li>
            <li>
                <img src="<c:url value="/themes/site/images/slides/slide-4.jpg"/>"  alt="" />
                <p class="flex-caption">
                    <span class="main" >Nam ultricies accumsan pellentesque</span>
                    <br />
                    <span class="secondary clearfix" >In justo orci, ornare vitae nulla sed, suscipit suscipit augue</span>
                </p>
            </li>
        </ul><!--//slides-->
    </div><!--//flexslider-->





    <div class="row cols-wrapper">
        <div class="col-md-3">
            <section class="events">
                <h1 class="section-heading text-highlight"><span class="line">Events</span></h1>
                <div class="section-content">
                    <div class="event-item">
                        <p class="date-label">
                            <span class="month">FEB</span>
                            <span class="date-number">18</span>
                        </p>
                        <div class="details">
                            <h2 class="title">Open Day</h2>
                            <p class="time"><i class="fa fa-clock-o"></i>10:00am - 18:00pm</p>
                            <p class="location"><i class="fa fa-map-marker"></i>East Campus</p>
                        </div><!--//details-->
                    </div><!--event-item-->
                    <div class="event-item">
                        <p class="date-label">
                            <span class="month">SEP</span>
                            <span class="date-number">06</span>
                        </p>
                        <div class="details">
                            <h2 class="title">E-learning at College Green</h2>
                            <p class="time"><i class="fa fa-clock-o"></i>10:00am - 16:00pm</p>
                            <p class="location"><i class="fa fa-map-marker"></i>Learning Center</p>
                        </div><!--//details-->
                    </div><!--event-item-->
                    <div class="event-item">
                        <p class="date-label">
                            <span class="month">JUN</span>
                            <span class="date-number">23</span>
                        </p>
                        <div class="details">
                            <h2 class="title">Career Fair</h2>
                            <p class="time"><i class="fa fa-clock-o"></i>09:45am - 16:00pm</p>
                            <p class="location"><i class="fa fa-map-marker"></i>Library</p>
                        </div><!--//details-->
                    </div><!--event-item-->
                    <div class="event-item">
                        <p class="date-label">
                            <span class="month">May</span>
                            <span class="date-number">17</span>
                        </p>
                        <div class="details">
                            <h2 class="title">Science Seminar</h2>
                            <p class="time"><i class="fa fa-clock-o"></i>14:00pm - 18:00pm</p>
                            <p class="location"><i class="fa fa-map-marker"></i>Library</p>
                        </div><!--//details-->
                    </div><!--event-item-->
                    <a class="read-more" href="events.html">All events<i class="fa fa-chevron-right"></i></a>
                </div><!--//section-content-->
            </section><!--//events-->
        </div><!--//col-md-3-->
        <div class="col-md-6">
            <section class="course-finder">
                <h1 class="section-heading text-highlight"><span class="line">Course Finder</span></h1>
                <div class="section-content">
                    <form class="course-finder-form" action="#" method="get">
                        <div class="row">
                            <div class="col-md-5 col-sm-5 subject">
                                <select class="form-control subject">
                                    <option>Choose a subject area</option>
                                    <option>Accounting & Finance</option>
                                    <option>Biological Sciences</option>
                                    <option>Business Studies</option>
                                    <option>Computer Science</option>
                                    <option>Creative Arts & Media</option>
                                    <option>Drama</option>
                                    <option>Education</option>
                                    <option>Engineering</option>
                                    <option>Film Studies</option>
                                    <option>Fitness Training</option>
                                    <option>Hospitality</option>
                                    <option>History</option>
                                    <option>International Relations</option>
                                    <option>Law</option>
                                    <option>Mathematics</option>
                                    <option>Music</option>
                                    <option>Physics</option>
                                    <option>Religion</option>
                                    <option>Social Science</option>
                                </select>
                            </div>
                            <div class="col-md-7 col-sm-7 keywords">
                                <input class="form-control pull-left" type="text" placeholder="Search keywords" />
                                <button type="submit" class="btn btn-theme"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </form><!--//course-finder-form-->
                    <a class="read-more" href="courses.html">View all our courses<i class="fa fa-chevron-right"></i></a>
                </div><!--//section-content-->
            </section><!--//course-finder-->
            <section class="video">
                <h1 class="section-heading text-highlight"><span class="line">Video Tour</span></h1>
                <div class="carousel-controls">
                    <a class="prev" href="#videos-carousel" data-slide="prev"><i class="fa fa-caret-left"></i></a>
                    <a class="next" href="#videos-carousel" data-slide="next"><i class="fa fa-caret-right"></i></a>
                </div><!--//carousel-controls-->

                <div class="section-content">
                    <div id="videos-carousel" class="videos-carousel carousel slide">
                        <div class="carousel-inner">
                            <div class="item active">
                                <iframe class="video-iframe" src="http://www.youtube.com/embed/r9LelXa3U_I?rel=0&amp;wmode=transparent" frameborder="0" allowfullscreen=""></iframe>
                            </div><!--//item-->
                            <div class="item">
                                <iframe class="video-iframe" src="http://www.youtube.com/embed/RcGyVTAoXEU?rel=0&amp;wmode=transparent" frameborder="0" allowfullscreen=""></iframe>
                            </div><!--//item-->
                            <div class="item">
                                <iframe class="video-iframe" src="http://www.youtube.com/embed/Ks-_Mh1QhMc?rel=0&amp;wmode=transparent" frameborder="0" allowfullscreen=""></iframe>
                            </div><!--//item-->
                        </div><!--//carousel-inner-->
                    </div><!--//videos-carousel-->
                    <p class="description">Aenean feugiat a diam tempus sodales. Quisque lorem nulla, ultrices imperdiet malesuada at, suscipit vel lorem. Nulla dignissim nisi ac aliquet semper.</p>
                </div><!--//section-content-->
            </section><!--//video-->
        </div>
        <div class="col-md-3">
            <section class="links">
                <h1 class="section-heading text-highlight"><span class="line">Quick Links</span></h1>
                <div class="section-content">
                    <p><a href="#"><i class="fa fa-caret-right"></i>E-learning Portal</a></p>
                    <p><a href="#"><i class="fa fa-caret-right"></i>Gallery</a></p>
                    <p><a href="#"><i class="fa fa-caret-right"></i>Job Vacancies</a></p>
                    <p><a href="#"><i class="fa fa-caret-right"></i>Contact</a></p>
                </div><!--//section-content-->
            </section><!--//links-->
            <section class="testimonials">
                <h1 class="section-heading text-highlight"><span class="line"> Testimonials</span></h1>
                <div class="carousel-controls">
                    <a class="prev" href="#testimonials-carousel" data-slide="prev"><i class="fa fa-caret-left"></i></a>
                    <a class="next" href="#testimonials-carousel" data-slide="next"><i class="fa fa-caret-right"></i></a>
                </div><!--//carousel-controls-->
                <div class="section-content">
                    <div id="testimonials-carousel" class="testimonials-carousel carousel slide">
                        <div class="carousel-inner">
                            <div class="item active">
                                <blockquote class="quote">
                                    <p><i class="fa fa-quote-left"></i>I’m very happy interdum eget ipsum. Nunc pulvinar ut nulla eget sollicitudin. In hac habitasse platea dictumst. Integer mattis varius ipsum, posuere posuere est porta vel. Integer metus ligula, blandit ut fermentum a, rhoncus in ligula. Duis luctus.</p>
                                </blockquote>
                                <div class="row">
                                    <p class="people col-md-8 col-sm-3 col-xs-8"><span class="name">Marissa Spencer</span><br /><span class="title">Curabitur commodo</span></p>
                                    <img class="profile col-md-4 pull-right" src="<c:url value="/themes/site/images/testimonials/profile-1.png"/>"  alt="" />
                                </div>
                            </div><!--//item-->
                            <div class="item">
                                <blockquote class="quote">
                                    <p><i class="fa fa-quote-left"></i>
                                        I'm very pleased commodo gravida ultrices. Sed massa leo, aliquet non velit eu, volutpat vulputate odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse porttitor metus eros, ut fringilla nulla auctor a.</p>
                                </blockquote>
                                <div class="row">
                                    <p class="people col-md-8 col-sm-3 col-xs-8"><span class="name">Marco Antonio</span><br /><span class="title"> Gravida ultrices</span></p>
                                    <img class="profile col-md-4 pull-right" src="<c:url value="/themes/site/images/testimonials/profile-2.png"/>"  alt="" />
                                </div>
                            </div><!--//item-->
                            <div class="item">
                                <blockquote class="quote">
                                    <p><i class="fa fa-quote-left"></i>
                                        I'm delighted commodo gravida ultrices. Sed massa leo, aliquet non velit eu, volutpat vulputate odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse porttitor metus eros, ut fringilla nulla auctor a.</p>
                                </blockquote>
                                <div class="row">
                                    <p class="people col-md-8 col-sm-3 col-xs-8"><span class="name">Kate White</span><br /><span class="title"> Gravida ultrices</span></p>
                                    <img class="profile col-md-4 pull-right" src="<c:url value="/themes/site/images/testimonials/profile-3.png"/>"  alt="" />
                                </div>
                            </div><!--//item-->

                        </div><!--//carousel-inner-->
                    </div><!--//testimonials-carousel-->
                </div><!--//section-content-->
            </section><!--//testimonials-->
        </div><!--//col-md-3-->
    </div><!--//cols-wrapper-->

    <section class="awards">
        <div id="awards-carousel" class="awards-carousel carousel slide">
            <div class="carousel-inner">
                <div class="item active">
                    <ul class="logos">
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award1.jpg"/>  alt="" /></a>
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award2.jpg"/>"  alt="" /></a>
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award3.jpg"/>"  alt="" /></a>
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award4.jpg"/>"  alt="" /></a>
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award5.jpg"/>"  alt="" /></a>
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#"><img class="img-responsive" src="<c:url value="/themes/site/images/awards/award6.jpg"/>"  alt="" /></a>
                        </li>
                    </ul><!--//slides-->
                </div><!--//item-->

                <div class="item">
                    <ul class="logos">
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award7.jpg"  alt="" />
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award6.jpg"  alt="" />
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award5.jpg"  alt="" />
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award4.jpg"  alt="" />
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award3.jpg"  alt="" />
                        </li>
                        <li class="col-md-2 col-sm-2 col-xs-4">
                            <img class="img-responsive" src="themes/site/images/awards/award2.jpg"  alt="" />
                        </li>
                    </ul><!--//slides-->
                </div><!--//item-->
            </div><!--//carousel-inner-->
            <a class="left carousel-control" href="#awards-carousel" data-slide="prev">
                <i class="fa fa-angle-left"></i>
            </a>
            <a class="right carousel-control" href="#awards-carousel" data-slide="next">
                <i class="fa fa-angle-right"></i>
            </a>

        </div>
    </section>
</div><!--//content-->