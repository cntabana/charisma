<?php
$model = new MembersBoot;
$this->breadcrumbs=array(
	'Members',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('members-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>

<h3>Members</h3>
<hr />

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>



<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<? 

//$criteria2 = new CDbCriteria;
$this->widget('bootstrap.widgets.TbGridView', array(
    'id' => 'members-grid',
    'itemsCssClass' => 'table-bordered items',
    'dataProvider' => $model->search(),
    'columns'=>array(
        array(
           'class' => 'editable.EditableColumn',
           'name' => 'id',
           'headerHtmlOptions' => array('style' => 'width: 30px'),
                         
        ),
         array( 
            //'class' => 'editable.EditableColumn',
            'header'=>'Membership Card',
            'name' => 'cardnumber',
          
          ), 
    
         array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Firstname',
            'name' => 'firstname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('members/UpdateBooster'),
                'placement' => 'right',
            )
          ), 
          array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Surname',
            'name' => 'lastname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('members/UpdateBooster'),
                'placement' => 'right',
            )
          ),
          array( 
            'class' => 'editable.EditableColumn',
            'name' => 'issuedate',
  
              'editable' => array(
                  'type'          => 'date',
                  'viewformat'    => 'dd.mm.yyyy',
                  'url'           => $this->createUrl('members/UpdateBooster'),
                  'placement'     => 'right',
              )
          ),  
          array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Issued Date',
            'name' => 'issuedate',
       
              'editable' => array(
              'type'          => 'combodate',
              'url'           => $this->createUrl('members/UpdateBooster'),
              'placement'     => 'right',
              'format'      => 'YYYY-MM-DD', //in this format date sent to server  
              'viewformat'  => 'DD/MM/YYYY', //in this format date is displayed
              'template'    => 'DD / MMM / YYYY ', //template for dropdowns
               'combodate'   => array('minYear' => 1920, 'maxYear' => 2099), 
              )
          ),  

          array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Expire Date',
            'name' => 'expireddate',
                 'editable' => array(
                  'type'          => 'combodate',
              'url'           => $this->createUrl('members/UpdateBooster'),
              'placement'     => 'right',
              'format'      => 'YYYY-MM-DD', //in this format date sent to server  
              'viewformat'  => 'DD/MM/YYYY', //in this format date is displayed
              'template'    => 'DD / MMM / YYYY ', //template for dropdowns
               'combodate'   => array('minYear' => 1920, 'maxYear' => 2099), 
              )
          ),  

           array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Birthday',
            'name' => 'birthday',
                 'editable' => array(
                  'type'          => 'combodate',
                  'url'           => $this->createUrl('members/UpdateBooster'),
                  'placement'     => 'right',
                  'format'      => 'YYYY-MM-DD', //in this format date sent to server  
                  'viewformat'  => 'DD/MM/YYYY', //in this format date is displayed
                  'template'    => 'DD / MMM / YYYY ', //template for dropdowns
               'combodate'   => array('minYear' => 1920, 'maxYear' => 2099), 
              )
          ), 
          array( 
                        'class' => 'editable.EditableColumn',
                        'header'=>'Gender',
                        'name' => 'sex',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('members/updateBooster'),
                           'source'=>$model->getGender(),
                      
                          
              ),
          ),

          array( 
              'class' => 'editable.EditableColumn',
              'header'=>'Type',
              'name' => 'type',
              'editable' => array(
                  'type'     => 'select',
                  'url'      => $this->createUrl('members/updateBooster'),
                 'source'=>$model->getType(),
       ),
),

             array( 
              'class' => 'editable.EditableColumn',
              'header'=>'Status',
              'name' => 'status',
              'editable' => array(
                  'type'     => 'select',
                  'url'      => $this->createUrl('members/updateBooster'),
                 'source'=>$model->getStatus(),
                 'placement'     => 'left',
                 'options'  => array(    //custom display 
                     'display' => 'js: function(value, sourceData) {
                          var selected = $.grep(sourceData, function(o){ return value == o.value; }),
                              colors = {1: "green", 0: "red"};
                          $(this).text(selected[0].text).css("color", colors[value]);    
                      }'
                  ),
                    //onsave event handler 
                 'onSave' => 'js: function(e, params) {
                      console && console.log("saved value: "+params.newValue);
                 }',
       ),
), 


array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
      'template' => '{view}  {delete}',
      'buttons' => array(
            'view' => array(
          'label'=> 'View',
          'url'=>'Yii::app()->createUrl("membersBoot/view", array("id"=>$data->id))',
           'options'=>array(
            'class'=>'btn btn-small view'
          )
        ),  
                
        'delete' => array(
          'label'=> 'Delete',
          'options'=>array(
            'class'=>'btn btn-small delete'
          )
        )
      ),
            'htmlOptions'=>array('style'=>'width: 80px'),
           )


)
)
);
 ?>


